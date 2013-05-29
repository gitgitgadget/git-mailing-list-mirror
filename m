From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH v2 2/8] rebase: cherry-pick: fix mode storage
Date: Wed, 29 May 2013 00:45:23 -0500
Message-ID: <CAMP44s29KwDMwF2X+_Lu7nyUaTkQAwC9pAx1nGNBe+WoktVGjA@mail.gmail.com>
References: <1369801000-3705-1-git-send-email-felipe.contreras@gmail.com>
	<1369801000-3705-3-git-send-email-felipe.contreras@gmail.com>
	<CANiSa6jMb0D0ZYDMHtWD3u9tsY+kuX4Gcxu7L-=ZU3X3WPJzJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 07:45:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhZCT-0007pr-Fc
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 07:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560Ab3E2FpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 01:45:25 -0400
Received: from mail-we0-f178.google.com ([74.125.82.178]:50020 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320Ab3E2FpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 01:45:25 -0400
Received: by mail-we0-f178.google.com with SMTP id q56so5851789wes.23
        for <git@vger.kernel.org>; Tue, 28 May 2013 22:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4KY2SSqdT1B5tyETqdlhlK92FHzriq71rWVamKsxT7Y=;
        b=jJUaJk5o8nv6rsmlrKZbSWV5RhS7XsjXRgUIYXjv4Xy0iAf9Vm+NXC88HZmmnJcDW9
         6PBGP/pld3Eq/HkKpQcfz5U6OgzMEn3P2Z7tBbYApctvmYuUwySPo4GNVbd0+2nqoX5K
         iz1RGq2mWswbP8J86hKGLbbyV8LMwW1+YwYEAep9WziqfyLGcdUip8s3FxwDucp2tHz2
         j3/ghkalbUTTMPXOURB+NLmMGU6Hlshj4GkEU77O/AuPxarj2+IXk6GoSjQk9FWzcMB0
         lFrbGQf3uVrwu2Dj2V/hLR1uyArnTXKyU9JBV7RP8ZRTnYAQleYUONGS4JQvxLD6VDA1
         ryLQ==
X-Received: by 10.194.216.136 with SMTP id oq8mr899609wjc.8.1369806323829;
 Tue, 28 May 2013 22:45:23 -0700 (PDT)
Received: by 10.194.47.4 with HTTP; Tue, 28 May 2013 22:45:23 -0700 (PDT)
In-Reply-To: <CANiSa6jMb0D0ZYDMHtWD3u9tsY+kuX4Gcxu7L-=ZU3X3WPJzJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225743>

On Wed, May 29, 2013 at 12:38 AM, Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
> Actually, are all of 2/8 - 7/8 fixes for things that broke in patch 1/8?

No, everything is already broken.

Try this:

--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -78,7 +78,7 @@ state_dir=
 action=
 preserve_merges=
 autosquash=
-keep_empty=
+keep_empty=yes
 test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t

 read_basic_state () {

And tell me what happens when you run the test suite:

Hint: This[1] is what would happen; everything breaks, not only the
tests that check for empty commits.

[1] http://article.gmane.org/gmane.comp.version-control.git/225652

-- 
Felipe Contreras
