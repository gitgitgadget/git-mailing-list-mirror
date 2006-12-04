X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Mon, 4 Dec 2006 22:36:48 +0100
Message-ID: <e7bda7770612041336s73e677ebh758b030f9f75c1d8@mail.gmail.com>
References: <20061130170625.GH18810@admingilde.org>
	 <4570AF8F.1000801@stephan-feder.de>
	 <Pine.LNX.4.64.0612011505190.3695@woody.osdl.org>
	 <4570BFA4.8070903@stephan-feder.de>
	 <e7bda7770612021057mc9f3eb9q7fc047dd1b5c235f@mail.gmail.com>
	 <Pine.LNX.4.64.0612021114270.3476@woody.osdl.org>
	 <e7bda7770612030119v197cbc95h6b3fa9e22b78c058@mail.gmail.com>
	 <Pine.LNX.4.64.0612030946150.3476@woody.osdl.org>
	 <e7bda7770612041226j4d4a5584m279afa9a2d7dfe74@mail.gmail.com>
	 <Pine.LNX.4.64.0612041234390.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 4 Dec 2006 21:36:58 +0000 (UTC)
Cc: sf-gmane@stephan-feder.de, sf <sf@b-i-t.de>, git@vger.kernel.org,
	"Martin Waitz" <tali@admingilde.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pxuSyWjyq92eQy4Y03EGxm44fuGO9Or7klnnX3zan7XIAjbDMY5/LhsmdrN+q4GEqRdSRt56H3SkQ7Sa0VLFmmvqRC6khNT4mNA+U8fcvy4pkFesOVs7Exk9WElW3VLybzSU6G+goSpbM5Kn6LyP2lNuPoSk4Ul/0k1TaQcCn3A=
In-Reply-To: <Pine.LNX.4.64.0612041234390.3476@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33256>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrLUd-0002Aa-I9 for gcvg-git@gmane.org; Mon, 04 Dec
 2006 22:36:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759755AbWLDVgx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 16:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937155AbWLDVgx
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 16:36:53 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:25367 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1759755AbWLDVgw (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec
 2006 16:36:52 -0500
Received: by nf-out-0910.google.com with SMTP id o25so19566nfa for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 13:36:49 -0800 (PST)
Received: by 10.49.91.6 with SMTP id t6mr23914nfl.1165268208869; Mon, 04 Dec
 2006 13:36:48 -0800 (PST)
Received: by 10.49.28.8 with HTTP; Mon, 4 Dec 2006 13:36:48 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 12/4/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
> So yeah, it's a bit hacky, but for the reasons I've tried to outline, I
> actually think that users _want_ hacky. Exactly because "deep integration"
> ends up having so many _bad_ features, so it's better to have a thin and
> simple layer that you can actually see past if you want to.

Thin and simple sounds very good. Let's try it with an example. Lets
say we have one apllication App1 and three librarys (Lib1, Lib2, Lib3)
with the following dependency-graph:

        App1
          /\
         /  \
   Lib1   Lib2
       \     /
        \   /
        Lib3 (don't really needed for this example but looks nice)

All components can be used individually and have their own upstream,
maintainer etc.

To compile App1 however, I need some files from both Lib1 and Lib2
specifying it's API. To satisfy these dependencies, It sounds
reasonable to link Lib2 and Lib3 submodules from App1. In your
concept, can I construct a modules file to fetch the API files and
