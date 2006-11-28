X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
From: Pazu <pazu@pazu.com.br>
Subject: Re: [PATCH 1.2/2 (fixed)] git-svn: fix output reporting from the delta fetcher
Date: Tue, 28 Nov 2006 14:56:29 -0200
Message-ID: <9e7ab7380611280856i1542090dhd284b5567fa2b19@mail.gmail.com>
References: <loom.20061124T143148-286@post.gmane.org>
	 <20061128054448.GA396@soma> <20061128102958.GA5207@soma>
	 <20061128105017.GA20366@soma>
	 <9e7ab7380611280445r4ebe344cw69cbc18a74c6122f@mail.gmail.com>
	 <9e7ab7380611280732k4e940380tbf2a96146807d671@mail.gmail.com>
	 <m2bqmr1rnw.fsf@ziti.fhcrc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 28 Nov 2006 16:57:04 +0000 (UTC)
Cc: "Eric Wong" <normalperson@yhbt.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=XeaE/mDV8rdXTmvF0s21/pF0oPJlogEtt81zr1r4Kk7KES3UiA4j+05WsFEXP06TlEWeRsViobR+qpil6b35TQDZvfk8jLlmyKveaAB5Irhc7pFx7jOW7ncIfdhCGQxlY4QH0Ao5iSzzo5giRcTCbH5TQ1rlP8Vgluwt3hubmW4=
In-Reply-To: <m2bqmr1rnw.fsf@ziti.fhcrc.org>
Content-Disposition: inline
X-Google-Sender-Auth: 1c51c98c70c77e93
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32548>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp6G5-0006ut-C4 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 17:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935890AbWK1Q4c convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006 11:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935891AbWK1Q4c
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 11:56:32 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:33619 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S935890AbWK1Q4b
 convert rfc822-to-8bit (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006
 11:56:31 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2627428nfa for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 08:56:30 -0800 (PST)
Received: by 10.49.91.14 with SMTP id t14mr8438620nfl.1164732989375; Tue, 28
 Nov 2006 08:56:29 -0800 (PST)
Received: by 10.48.216.6 with HTTP; Tue, 28 Nov 2006 08:56:29 -0800 (PST)
To: "Seth Falcon" <sethfalcon@gmail.com>
Sender: git-owner@vger.kernel.org

On 11/28/06, Seth Falcon <sethfalcon@gmail.com> wrote:

> Is CamelEar an empty directory (or was it an empty directory in the
> first fetch) by any chance?

No, neither. The directory isn't empty on the requested revision, nor
in the initial revision. Anyways=85

I've tried to init and fetch the repository again, and guess what, it
worked. So my bet that this was caused by a broken connection during
the initial fetch was probably right -- I'll try to "force" a broken
connection and see what happens=85

Hmmm.=85

mini:/tmp pazu$ git-svn init
https://tech.bga.bunge.com/BungeHomeExt/GLS/trunk/java/bg-cam
mini:/tmp pazu$ git-svn fetch
        A       bg-cam.ipr
        A       CamelWeb/CamelWeb.iml
        A       CamelWeb/.classpath
        A       CamelWeb/JavaSource/.emptyDir
        A       CamelWeb/.serverPreference
        A       CamelWeb/.website-config
        ...
        <<Here I turned AirPort off>>
Committing initial tree d14cd2aca9a6f15fdc8875212776c6a7cd111341
r8618 =3D 5a994a730da8dc8141fd116100a773061b7d4212
Creating fetcher for revision 5a994a730da8dc8141fd116100a773061b7d4212
Starting update on revision 9236
Opening CamelService/ejbModule/com/bunge/logistics/elevator/service/uti=
l/ElevatorConstants.java@8618
Error from SVN, (200003): Incomplete data: Delta source ended unexpecte=
dly

When I deactivated AirPort, git-svn hang for a long while, but it
finally timed out and just saved what it got so far as the initial
revision. Then when git-svn tried to fetch the next revision, it ended
up trying to open a file that wasn't checked out during the (broken)
initial fetch.

Well, it seems I've found the problem. Unfortunately I have no idea
how to fix that=85 I'll read some subversion books and source code to
figure that out.

