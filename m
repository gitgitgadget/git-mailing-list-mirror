X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Suggestion: drop 'g' in git-describe suffix
Date: Thu, 2 Nov 2006 12:12:32 +0100
Message-ID: <8aa486160611020312v42047716t6a13e6fa16eeae8@mail.gmail.com>
References: <eibh94$t7n$1@sea.gmane.org> <45494E20.1000503@shadowen.org>
	 <4549C083.9060805@xs4all.nl> <4549CA6B.4090909@shadowen.org>
	 <4549CE2A.3010808@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 2 Nov 2006 11:12:43 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c+MB6a1brhoZa1rIpQxO55VSXuMcJxZYpDGRqoRNB61Z+GmUpcYxDySddSyLUPl1g35rJJkg1y+W63TmUIcPdu4xDBlnPZlrBs+TrJf89g5ndhZX2LB//zgLcQzdXPPUEK/8C1lm4uEG4QfZK1gj4/7Wfhf22SMkD6d6XqLpQgk=
In-Reply-To: <4549CE2A.3010808@xs4all.nl>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30726>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfaUw-0004DS-KI for gcvg-git@gmane.org; Thu, 02 Nov
 2006 12:12:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752849AbWKBLMe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 06:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752848AbWKBLMe
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 06:12:34 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:60665 "EHLO
 wx-out-0506.google.com") by vger.kernel.org with ESMTP id S1752847AbWKBLMd
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 06:12:33 -0500
Received: by wx-out-0506.google.com with SMTP id s14so94276wxc for
 <git@vger.kernel.org>; Thu, 02 Nov 2006 03:12:33 -0800 (PST)
Received: by 10.70.52.1 with SMTP id z1mr554539wxz.1162465952812; Thu, 02 Nov
 2006 03:12:32 -0800 (PST)
Received: by 10.70.46.19 with HTTP; Thu, 2 Nov 2006 03:12:32 -0800 (PST)
To: hanwen@xs4all.nl
Sender: git-owner@vger.kernel.org

On 11/2/06, Han-Wen Nienhuys <hanwen@xs4all.nl> wrote:
> Andy Whitcroft escreveu:
> > Han-Wen Nienhuys wrote:
> >>
> >>   tag+sha1
> >>
> >> to separate the tag and the committish.
> >
> > Well there is a non-alphabet character in there, a minus (-).  The g
> > prefix on the sha1 _fragment_ it to indicate that it is in fact a
> > truncated sha1, not a complete one.

I think it is there to indicate it is a git commit sha1.

>
> is this policy documented somewhere?  None of the tools understand it.
>
> [lilydev@haring git]$ git describe
> v1.4.3.3-g1e1f76e
> [lilydev@haring git]$ git show g1e1f76e
> fatal: ambiguous argument 'g1e1f76e': unknown revision or path not in
> the working tree.
> Use '--' to separate paths from revisions
>

Use the complete output of describe:
$ git show v1.4.3.3-g1e1f76e

or the abbrev sha1:
$ git show 1e1f76e

> My suggestion is to use
>
>    v1.4.3.3+1e1f76e

My suggestion is to use:

v1.4.3.3-git1e1f76e

to make clear that it is a git revision version.

One problem I see with this scheme (either 'g', 'git' of '+') is that
it does not provide an increasing version number, even for
fast-forwarding commits. Then it is not useful as a package version
number (deb or rpm). I've already seen deb packages with
version+git20061010. One possibility could be to add the number of
commits between the tag and the commit as:

v1.4.3.3-git12g1e1f76e

to provide a weak ordering for fast-forwarding commits. What do you thing?

