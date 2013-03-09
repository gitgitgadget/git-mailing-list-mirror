From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] Replace strcmp_icase with strequal_icase
Date: Sat, 9 Mar 2013 17:40:55 +0700
Message-ID: <CACsJy8CphBDKsAAKjCoze98jv=4U+3pN3cW1OYD5XNhYgfcVCA@mail.gmail.com>
References: <1362818574-16873-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sat Mar 09 11:42:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEHE2-0003ZC-AG
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 11:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756586Ab3CIKl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 05:41:27 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:41903 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756419Ab3CIKl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 05:41:26 -0500
Received: by mail-lb0-f182.google.com with SMTP id gg6so1929380lbb.41
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 02:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=lmd2gUgvekzbnxzFiQQ7/DUtcwDlAx74EmxEjvjNrdI=;
        b=FGd5XlLYkWwp+FqKEUw85XgIXftlvBbiYZ7MSIOpdLAXljJ0oKIWJ4gbzSJ96950d1
         w/0igoY2CkQa5fUVzQYs2pIRSCQt6j55V8j/JUdZB3MVJIEtaNDT+gle+KltEN3Ml97Y
         6ZjyZnYwmm4NiHElUqbKghVAyUIjNBp6yeaP5l9h3HY1g2lxIZPb0ir98RUceksBkwyF
         U3Ebb4ONuJaW11KPz7g0YRPbikqQ1myZq/KOOjedinCQjihy70o4EsTl08H/88t0q0XT
         Q8FwsHetvYCqb0hqnlF74q7agmPu3WkH3gDpRkj7lmBzgFsUv9aFbrYnYuwIopVV1GlK
         G7zA==
X-Received: by 10.112.100.41 with SMTP id ev9mr2251403lbb.34.1362825685276;
 Sat, 09 Mar 2013 02:41:25 -0800 (PST)
Received: by 10.114.25.226 with HTTP; Sat, 9 Mar 2013 02:40:55 -0800 (PST)
In-Reply-To: <1362818574-16873-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217718>

On Sat, Mar 9, 2013 at 3:42 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> To improve performance.

BTW, by rolling our own string comparison, we may lose certain
optimizations done by C library. In case of glibc, it may choose to
run an sse4.2 version where 16 bytes are compared at a time. Maybe we
encounter "string not equal" much often than "string equal" and such
an optimization is unncessary, I don't know. Measured numbers say it's
unncessary as my cpu supports sse4.2.
-- 
Duy
