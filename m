From: "Jacob Helwig" <jacob.helwig@gmail.com>
Subject: Re: is there an easier way to do this ?
Date: Mon, 29 Dec 2008 20:00:53 -0800
Message-ID: <8c9a060812292000k18ccd466g628ea4161bac188b@mail.gmail.com>
References: <gjc52u$ehc$4@ger.gmane.org> <gjc5t2$g02$4@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Zorba <cr@altmore.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 05:02:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHVo8-000167-PO
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 05:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbYL3EA4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 23:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752418AbYL3EAz
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 23:00:55 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:25802 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752185AbYL3EAy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Dec 2008 23:00:54 -0500
Received: by qw-out-2122.google.com with SMTP id 3so3981510qwe.37
        for <git@vger.kernel.org>; Mon, 29 Dec 2008 20:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=PhbiiKeud2p96CV/HLxi0a7HwMtGB/EztDj6N9aVmE0=;
        b=YXVpf6G/k5xsD5DG1t1+x2zTtUWo6FPX+4jBnjJR82zCwVAeY2+qxo0yYeP1eReqXx
         +VIIqbQ04h8HTz+OnAXdQ1zOYlDO1uNc90HfnAtfJ4mB3Hsn8L4nj3ShnNxwri/pF+xq
         sQ3Lk7w2/zbCDJyP9DBgvERHd9Lof4tB570uI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kvl6ajMLNTFzvGMh8e2mlVp9ezJdBBgJB1IR6SKq9rCWTn0U40ME7d8BXZ1mXZo1U5
         OcfFyOnsILp976zcdYyXv786QRw+RyypmjS5R0/Ubqx2SPEj97XUTFHfLYOP+4IJ6vnq
         jR7Ho1nJYdc92HkVNN9c6of29R83lXtU/82ug=
Received: by 10.214.147.11 with SMTP id u11mr11972337qad.131.1230609653497;
        Mon, 29 Dec 2008 20:00:53 -0800 (PST)
Received: by 10.214.216.7 with HTTP; Mon, 29 Dec 2008 20:00:53 -0800 (PST)
In-Reply-To: <gjc5t2$g02$4@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104152>

On Mon, Dec 29, 2008 at 19:51, Zorba <cr@altmore.co.uk> wrote:
> The manual shows you can SHOW untracked files, but not add them as part of
> the commit -a jig
>
> Seems a bit strange that git-add operates on both exisging and new files
> when used standalone, but its behaviour changes when encapsulated in
> commit -a...
>
> So, I thought maybe $ git commit -a, then $ git add .
> but then the files tracked have missed the commit boat they were meant to be
> on, haven't they,
>
> hang on -
> what about
>
> $ git add .
> $ git commit -a
>
> I do believe I've cracked it
> if so, it seems a bit wasteful, 2x adds (one explicti and one embedded
> in -a) ? shame on you linux kernel guys, i'd have expected better :-)
>
> "Zorba" <cr@altmore.co.uk> wrote in message
> news:gjc52u$ehc$4@ger.gmane.org...
>> ok, now I'm in this for real, archiving versions of our website project
>> (5k files approx)
>>
>> so here is the workflow:
>>
>> - copy version 1 files into GIT dir
>>
>> - open git bash
>>
>> $ git init
>>
>> $ git add .
>>
>> $ git commit -m "version1"
>>
>> all vanilla ? cool
>> next job = store version 2, so delete version 1 files from GIT dir, copy
>> in version 2
>> version2 has different files from 1 - which ones? Out of 5k files could be
>> 1% = 50 new ones, and same amount removed. Why should I care, with such a
>> powerful friend as git around, n'est pas?
>> THIS TIME we are going to be CLEVER and use "-a" flag on commit to pick up
>> any files that have been REMOVED (or "deleted" in git-speak)
>>
>> $ git commit -a -m "version2"
>>
>> BUT this does not pick up any new ones that have been added,
>>
>> and when we run
>>
>> $ git status > ../git_status.txt
>>
>> these are referred to as "untracked files"
>> only problem there are 50 ish
>> is there not another flag on git commit to treat any untracked file as a
>> new file ?
>> (would save me typing or creating a list out of these untracked ones and
>> feeding them into git add)
>>
>> I know, I realise now I should have looked up git-commit in the manual -
>> in case its not there, pls enlighten me !
>>
>>
>>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

If you do an explicit git add, then you don't need the -a on git
commit, since everything you want to commit will already be in the
index for git commit to work with.
