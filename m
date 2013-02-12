From: Reuben Thomas <rrt@sc3d.org>
Subject: Re: git-diff(1) appears to contradict itself
Date: Tue, 12 Feb 2013 03:09:03 +0000
Message-ID: <CAOnWdohn-NhTqOzdNbqmUPkJz2+TyikPbnxnVD0rC7Rfnm-o5w@mail.gmail.com>
References: <CAOnWdojOT61XOY6JxL-3sR4W8N0katShsSLsOsuJ0-PuM9Vemg@mail.gmail.com>
	<7v1ucmjl6x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 04:16:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U56MT-0007BV-Vb
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 04:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710Ab3BLDQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 22:16:26 -0500
Received: from exprod7og114.obsmtp.com ([64.18.2.215]:44611 "HELO
	exprod7og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751425Ab3BLDQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 22:16:26 -0500
Received: from mail-ee0-f72.google.com ([74.125.83.72]) (using TLSv1) by exprod7ob114.postini.com ([64.18.6.12]) with SMTP
	ID DSNKURm0CV3kjMDbwlzjskmbwMN1XoKlLFcu@postini.com; Mon, 11 Feb 2013 19:16:25 PST
Received: by mail-ee0-f72.google.com with SMTP id b15so7897828eek.7
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 19:16:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:x-received:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=3LxWN3nmIOjLnXZw3kkDnczJsWNXIBrDqZalmHG6RG8=;
        b=KIJjrovfOwp1QuckVvEXeKsStH6TApLOwgASCqcmB1ZYJRiqICwxMKBvnCyFnbPigd
         FKCT8n1kGkQZVdqJD37VWCKnyL1aSdvNaLDIFS0yBOGkzTAiQE3oRX7yUCbcQ3C0pz5c
         NHcD36lbSa5x4KWvXR3dByDuAlaOTFmZolT4LyR7e9C00R1QUt3ZnM8lHjYOAe4FAbwz
         v5Yw362Ye+vgHmTOIZguWRxTBjwkE77Dxl5cixJoW4FE8qogpxyu4iwGIAh6bNEc/PW/
         pi2JwMU2YtVZygUGXkkiNORNXjWQFhIjbVckgnYIoBz35q3Kv1Rogxe57LJV8xxSdLiu
         aDwQ==
X-Received: by 10.112.88.5 with SMTP id bc5mr6593603lbb.50.1360638543290;
        Mon, 11 Feb 2013 19:09:03 -0800 (PST)
X-Received: by 10.112.88.5 with SMTP id bc5mr6593601lbb.50.1360638543147; Mon,
 11 Feb 2013 19:09:03 -0800 (PST)
Received: by 10.152.135.36 with HTTP; Mon, 11 Feb 2013 19:09:03 -0800 (PST)
In-Reply-To: <7v1ucmjl6x.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQmrcXnZP0B5PpHh44EGnuuj5xgrNWmR1AVgmRKitoOSCGrpb6PIgasdsPsJxkzXYHOg0flDAjxr3XQ+zLaR8I8PQLYixUdBp06fz/AHmDWF3Kqob6kGHrT71JdD+rUqCjZrmjrSXhFD3vOS2jCd5FmPUjPdBA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216115>

On 12 February 2013 02:54, Junio C Hamano <gitster@pobox.com> wrote:
> Reuben Thomas <rrt@sc3d.org> writes:
>
>> Under the --color=<when> option, it says:
>>
>> Show colored diff. The value must be always (the default for <when>),
>> never, or auto. The default value is never.
>
> I think it wants to say this:
>
>     You can say "diff --color" without saying "when".  That is the
>     same as saying "diff --color=always".
>
>     If you do not say "--color" at all, that is exactly the same as
>     saying "diff --color=never".
>
> Patches welcome.

Thanks for the explanation. Something like this, then:

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 7a87473..9a02992 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -174,9 +174,9 @@ any of those replacements occurred.
     `diff.submodule` configuration variable.

 --color[=<when>]::
-    Show colored diff.
-    The value must be `always` (the default for `<when>`), `never`, or `auto`.
-    The default value is `never`.
+    Show colored diff (off by default).
+    The value must be `always`, `never`, or `auto`.
+    `--color` is the same as `--color=always`.
 ifdef::git-diff[]
     It can be changed by the `color.ui` and `color.diff`
     configuration settings.

? I guess other commands that work the same, such as git-grep, could
do with a similar patch (indeed, I based my wording on that in the
git-grep page, but that has different problems.) Or you could use the
same fragment twice if that is possible in your system?

--
http://rrt.sc3d.org
