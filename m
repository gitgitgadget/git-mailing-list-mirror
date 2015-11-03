From: "Ch'Gans" <chgans@gna.org>
Subject: Re: Strange diff-index output
Date: Tue, 3 Nov 2015 14:00:33 +1300
Message-ID: <CABxGUTihNmHqp-RovCVreTRqoK_sj+KCjRQE_YOVZ8OQzOHHoA@mail.gmail.com>
References: <CABxGUTj-5vdmyVGkKuoMdBAG2EAQvLJNYLLA++T2hNFvGRmb0w@mail.gmail.com>
	<1446510469.4131.35.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 02:00:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtPy1-0004De-GE
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 02:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754220AbbKCBAh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Nov 2015 20:00:37 -0500
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36282 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609AbbKCBAe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Nov 2015 20:00:34 -0500
Received: by qkcl124 with SMTP id l124so649872qkc.3
        for <git@vger.kernel.org>; Mon, 02 Nov 2015 17:00:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=amLsjuj7sTkUdq4L/01KpbCCzDMQVX/2kLIC1302mXU=;
        b=tK9obR9rsUAxKjCHyVqJkAVgZIrjT4mPyX0IrFslNAbYVd+rogQ56RIQLwYivtFta7
         XfyRSLFVREn+vQzIWhXvHFloNNi3MI0N61UnYmmB0VZ6DWj7tVLEq+2EFRVTIyNMPyUs
         e9dqJX7Co0WLe8/7gCD1lCUG3T5iQ8GKWoAntiExGJUaijwx7kmg7EnhVoycBZB+LMIF
         dr9/ab2ZQ3uerY3a1KsLXkr3odlpGWtoW5Qs5YXDbtcuP5tO6CYKNetldOnxfPM8gTa/
         wKuvyxgp2rxSVRZ5ASVRL1Kplm1LsDLstKP3dpsDrx92VdzXiYxkIbXpQSeSVQ3DaEOp
         LZrQ==
X-Received: by 10.55.212.89 with SMTP id l86mr33370447qki.64.1446512433328;
 Mon, 02 Nov 2015 17:00:33 -0800 (PST)
Received: by 10.140.107.70 with HTTP; Mon, 2 Nov 2015 17:00:33 -0800 (PST)
In-Reply-To: <1446510469.4131.35.camel@twopensource.com>
X-Google-Sender-Auth: 547NAFca2qTjql_KolnB7wt-CxQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280740>

On 3 November 2015 at 13:27, David Turner <dturner@twopensource.com> wr=
ote:
> On Tue, 2015-11-03 at 12:59 +1300, Ch'Gans wrote:
>> Hi there,
>>
>> We're using a script to verify that what we are building is clean
>> against our git repository, for this we're using "git rev-parse
>> --short HEAD" to get the current hash and "git diff-index --quiet
>> HEAD" to check for local modification.
>
> See this note from the git diff-index man page:
>            Note
>            As with other commands of this type, git diff-index does n=
ot
>            actually look at the contents of the file at all. So maybe
>            kernel/sched.c hasn=E2=80=99t actually changed, and it=E2=80=
=99s just that
> you
>            touched it. In either case, it=E2=80=99s a note that you n=
eed to git
>            update-index it to make the index be in sync.
>
> You can either add an update-index to your script, or use git status
> --porcelain.

Hi David,

I first tried "git update-index" but it didn't work. However "git
update-index --refresh" seems to fix our problem.
I didn't get why "--refresh" is needed thought, I'm really not
familiar with the caching aspect of git.
Anyway, I think that this fix is what I need right now.

Thanks,
Chris

>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
