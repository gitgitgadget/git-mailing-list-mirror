From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH V2 1/2] t9801: check git-p4's branch detection and client view together
Date: Mon, 20 Apr 2015 23:25:17 +0100
Message-ID: <48EB5BF2-166D-45F5-9573-0C9E16CAC2B9@gmail.com>
References: <1429441009-17775-1-git-send-email-vitor.hda@gmail.com> <1429441009-17775-2-git-send-email-vitor.hda@gmail.com> <xmqqtwwbmk16.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 00:25:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkK88-0006uJ-Fr
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 00:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751663AbbDTWZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 18:25:23 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37128 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbbDTWZW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 18:25:22 -0400
Received: by widdi4 with SMTP id di4so1104668wid.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 15:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=aESMFtVE8Mz3FPlFFzlI7Pol4agCgiMCbvtrywLfYiA=;
        b=Izm9u5s+vwFf9EA6jiZwxPVxNClmBmQ81PXiPXjR+lIbxWWAnmYbcKD6oxJJQrwdGG
         /dFzMEr6oavmbACE/3CeZyK8P2vtEMNISf5i9plxtKIYsRyXAQo/dL3O1lk8MjLC2OYF
         gTjJiUgoNfKLG32zw8sv/pZL5Hvmhc6hpweW1grPfQpRIlDw/1Hn407xSI7oguXP3mFz
         EjWCqS8eq1pS8SxHZxPUk2XzuyBwC+LHnpxByP95X4/VyLcVpVDhHKXdQAEGNn0gM46e
         mkeVcZyOL9O881ag08VXDL2u+/txGunB09JoFqz9SEcBw/HPRf57G44C5Cv+leaj3+Ya
         Gm/w==
X-Received: by 10.194.81.1 with SMTP id v1mr33732757wjx.50.1429568721225;
        Mon, 20 Apr 2015 15:25:21 -0700 (PDT)
Received: from android-339016f4e6b2c83f.lan (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id nb9sm421801wic.10.2015.04.20.15.25.19
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Apr 2015 15:25:20 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <xmqqtwwbmk16.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267506>

On April 20, 2015 6:43:49 AM GMT+01:00, Junio C Hamano <gitster@pobox.com> wrote:
>Vitor Antunes <vitor.hda@gmail.com> writes:
>
>> Add failing scenario where branch detection is enabled together with
>> use client view. In this specific scenario git-p4 will break when the
>> perforce client view removes part of the depot path.
>
>I somehow cannot parse "together with use client view", especially
>the word "use".  Is it "user client view" or something (I am not
>familiar with p4 lingo), or perhaps "use of client view"?

I meant "spec" instead of "view". As in - -use-client-spec.

In perforce you need to configure your workspace using a client specification.
One of the configured values is the client view, which maps files/folders in the
server to locations in your local workspace. What I'm trying to fix with these
patches is the ability of git-p4 to process the client view definition through
the use of "p4 where" to determine the correct location of the local files, such
that it is able to apply the necessary patches for submission to the perforce
server.

While thinking about client views I completely forgot that the git-p4 argument
that enables thos feature uses "spec" and not "view".
