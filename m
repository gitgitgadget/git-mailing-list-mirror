X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 19:57:46 +0100
Message-ID: <e7bda7770612021057mc9f3eb9q7fc047dd1b5c235f@mail.gmail.com>
References: <20061130170625.GH18810@admingilde.org> <457061A7.2000102@b-i-t.de>
	 <Pine.LNX.4.64.0612011134080.3695@woody.osdl.org>
	 <200612012306.41410.Josef.Weidendorfer@gmx.de>
	 <Pine.LNX.4.64.0612011423100.3695@woody.osdl.org>
	 <4570AF8F.1000801@stephan-feder.de>
	 <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org>
	 <4570BFA4.8070903@stephan-feder.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 2 Dec 2006 18:58:04 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dNlxl1nlC5lJLZnSBpE5wKY+aqfSnSyschrWPZhzgiUInSqknYTuAwNhtSsyOeExPZYFQJaMYHPC7rQgAmQp4oFDuKSmJqV9QGUoXktprPCIARxKTAAZ0Im1yZGytJRo16mUTs+HEFpNIbdDQwNxptXGXeSymAYurnGu8Epveag=
In-Reply-To: <4570BFA4.8070903@stephan-feder.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33032>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqa3c-0005DM-1D for gcvg-git@gmane.org; Sat, 02 Dec
 2006 19:57:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932953AbWLBS5s (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 13:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936565AbWLBS5s
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 13:57:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:54265 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S932953AbWLBS5s
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 13:57:48 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3904077nfa for
 <git@vger.kernel.org>; Sat, 02 Dec 2006 10:57:46 -0800 (PST)
Received: by 10.49.19.18 with SMTP id w18mr10830732nfi.1165085866528; Sat, 02
 Dec 2006 10:57:46 -0800 (PST)
Received: by 10.49.28.8 with HTTP; Sat, 2 Dec 2006 10:57:46 -0800 (PST)
To: sf-gmane@stephan-feder.de, "Linus Torvalds" <torvalds@osdl.org>, sf
 <sf@b-i-t.de>, git@vger.kernel.org, "Martin Waitz" <tali@admingilde.org>
Sender: git-owner@vger.kernel.org

> If you need a common infrastructure to be able to work with the
> submodule, then the submodule is not independent of of the supermodule.
> I see a contradiction in your requirements.

Here's an real-world example that doesn't contradict:

http://amarok.kde.org/wiki/Installation_HowTo#From_Anonymous_SVN

"svn co -N svn://anonsvn.kde.org/home/kde/trunk/extragear/multimedia
cd multimedia
svn co svn://anonsvn.kde.org/home/kde/branches/KDE/3.5/kde-common/admin
svn up amarok

To compile the sources (from the multimedia directory):"

and there's probably very few people that want to clone the entire KDE
multimedia sub&super-module in this case.

//Torgil


On 12/2/06, sf <sf-gmane@stephan-feder.de> wrote:
> Linus Torvalds wrote:
> >
> > On Fri, 1 Dec 2006, sf wrote:
> >> Linus Torvalds wrote:
> >> ...
> >>> In contrast, a submodule that we don't fetch is an all-or-nothing
> >>> situation: we simply don't have the data at all, and it's really a matter
> >>> of simply not recursing into that submodule at all - much more like not
> >>> checking out a particular part of the tree.
> >> If you do not want to fetch all of the supermodule then do not fetch the
> >> supermodule.
> >
> > So why do you want to limit it? There's absolutely no cost to saying "I
> > want to see all the common shared infrastructure, but I'm actually only
> > interested in this one submodule that I work with".
>
> If you need a common infrastructure to be able to work with the
> submodule, then the submodule is not independent of of the supermodule.
> I see a contradiction in your requirements.
>
> > Also, anybody who works on just the build infrastructure simply may not
> > care about all the submodules. The submodules may add up to hundreds of
> > gigs of stuff. Not everybody wants them. But you may still want to get the
> > common build infrastructure.
>
> See above.
>
> > In other words, your "all or nothing" approach is
> >  (a) not friendly
> > and
> >  (b) has no real advantages anyway, since modules have to be independent
> >      enough that you _can_ split them off for other reasons anyway.
> >
> > So forcing that "you have to take everything" mentality onyl has
> > negatives, and no positives. Why do it?
>
> (There have been lots of use cases for shallow clones but for a long
> time git did not support them).
>
> If you can extend this partial fetch feature to the non-subproject case
> I would agree with your reasoning. What makes the subprojects so special
> in this regard. Do I have to turn a plain tree into a subproject to be
> able to ignore it? Once you can restrict fetches to parts of the
> contents you get the ability to restrict fetches to the "common
> infrastructure" and selected submodules for free.
>
> Regards
>
> Stephan
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
