From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 1/6] t6300 (for-each-ref): clearly demarcate setup
Date: Sat, 16 Nov 2013 18:11:48 -0500
Message-ID: <CAPig+cRz3_JSLJCu5AndSnreT91OqcQf_p+9-bUE5MUO_E066g@mail.gmail.com>
References: <1384513148-22633-1-git-send-email-artagnon@gmail.com>
	<1384513148-22633-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 17 00:12:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vhp2I-00045Z-9L
	for gcvg-git-2@plane.gmane.org; Sun, 17 Nov 2013 00:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351Ab3KPXLw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Nov 2013 18:11:52 -0500
Received: from mail-la0-f44.google.com ([209.85.215.44]:45071 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031Ab3KPXLu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Nov 2013 18:11:50 -0500
Received: by mail-la0-f44.google.com with SMTP id ep20so3861670lab.3
        for <git@vger.kernel.org>; Sat, 16 Nov 2013 15:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Ur/t2RnsnXcnYyVXHZhKvMTI/WYWChMfeIo7YmkORTU=;
        b=VdYzeTbW6ljRemv54VRz5NHnBP5lmiNy10AZpfnMD7/28BRqHFOBX+opZC0sbuAg7q
         DRp33uKi7sszZMJUe2KoGEeLhfRDTTlQXuBUwTrmwT8QPxIOJCFlehZTViTov8pG/CSf
         CzjucwUno2o0sWbdhY22qLhPdjRNFos1wm3EiOoM3giO2NRisYPCozh53D+4RkV4dEBn
         pW0GK/vEQkSdgiFImnUhzqvXotO2sn2hhDUvWnaybKFVYAZp7NVlZwHLoKSdFA/5/Aro
         VJGA8YShuIHa6mxn55nDwVbGmZuOZTF6Tt4W1QI5nTfodTFMy+21+wGdOb6KRMYsq4uX
         xeCg==
X-Received: by 10.112.16.2 with SMTP id b2mr449402lbd.27.1384643508736; Sat,
 16 Nov 2013 15:11:48 -0800 (PST)
Received: by 10.114.200.180 with HTTP; Sat, 16 Nov 2013 15:11:48 -0800 (PST)
In-Reply-To: <1384513148-22633-2-git-send-email-artagnon@gmail.com>
X-Google-Sender-Auth: 7CksZYcrGNNIzpHV-arPVdeQAGc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237944>

On Fri, Nov 15, 2013 at 5:59 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Condense the two-step setup into one step, and give it an appropriate
> name.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t6300-for-each-ref.sh | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 752f5cb..72d282f 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -18,16 +18,13 @@ setdate_and_increment () {
>      export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
>  }
>
> -test_expect_success 'Create sample commit with known timestamp' '
> +test_expect_success setup '
>         setdate_and_increment &&
>         echo "Using $datestamp" > one &&
>         git add one &&
>         git commit -m "Initial" &&
>         setdate_and_increment &&
>         git tag -a -m "Tagging at $datestamp" testtag

Broken &&-chain here after these functions are combined.

> -'
> -
> -test_expect_success 'Create upstream config' '
>         git update-ref refs/remotes/origin/master master &&
>         git remote add origin nowhere &&
>         git config branch.master.remote origin &&
> --
> 1.8.5.rc0.6.gfd75b41
