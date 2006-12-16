X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 16 Dec 2006 16:38:50 +0100
Message-ID: <e7bda7770612160738w68a47790vef922804efd56c76@mail.gmail.com>
References: <20061130170625.GH18810@admingilde.org>
	 <e7bda7770612150943j71a7362bmb509cea3b7756003@mail.gmail.com>
	 <200612152242.50472.Josef.Weidendorfer@gmx.de>
	 <e7bda7770612151543o39c9d233q91ea643a134196d3@mail.gmail.com>
	 <e7bda7770612151713k418434e6gd8d565e49a766477@mail.gmail.com>
	 <e7bda7770612151720w2e65fe83s9942e1ec1f7092a2@mail.gmail.com>
	 <elviac$63t$1@sea.gmane.org>
	 <e7bda7770612160040v1a769153p909a8cd40e5ea991@mail.gmail.com>
	 <em0fpq$45b$1@sea.gmane.org>
	 <e7bda7770612160705l61d1f350n70a8ba91754491c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 16 Dec 2006 15:38:59 +0000 (UTC)
Cc: "Josef Weidendorfer" <Josef.Weidendorfer@gmx.de>,
	"R. Steve McKown" <rsmckown@yahoo.com>, git@vger.kernel.org,
	"Linus Torvalds" <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ba0pHV9fHA8scNaaCDZDQGU9XHW1EBijlfIYfxkV4y1TGBsTfn00AKBtrNkuWGNr0K9IbrEH46WVtOc/80FzgsdCkVX1haPN1w5BnZ6kIzgIfu7pQe2/r9UI6YdnJ9bMhuMIdW4SMlEQRcCjbsnXWa8ZGcXj34iN/eY1g93L7wI=
In-Reply-To: <e7bda7770612160705l61d1f350n70a8ba91754491c9@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34622>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gvbcl-0007YJ-Iz for gcvg-git@gmane.org; Sat, 16 Dec
 2006 16:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161066AbWLPPix (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 16 Dec 2006
 10:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbWLPPix
 (ORCPT <rfc822;git-outgoing>); Sat, 16 Dec 2006 10:38:53 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:29842 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1161066AbWLPPiw (ORCPT <rfc822;git@vger.kernel.org>); Sat, 16 Dec
 2006 10:38:52 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1435898nfa for
 <git@vger.kernel.org>; Sat, 16 Dec 2006 07:38:51 -0800 (PST)
Received: by 10.49.54.3 with SMTP id g3mr1739121nfk.1166283530889; Sat, 16
 Dec 2006 07:38:50 -0800 (PST)
Received: by 10.49.28.8 with HTTP; Sat, 16 Dec 2006 07:38:50 -0800 (PST)
To: "Jakub Narebski" <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/16/06, Torgil Svensson <torgil.svensson@gmail.com> wrote:
> On 12/16/06, Jakub Narebski <jnareb@gmail.com> wrote:
> > All fine, but this does not and I think cannot protect us from the
> > fact that we can have <sha1 of tree/blob> which doesn't match
> > <sha1 of commit>.
>
> True, that will be a real problem. Unless we have a bug in git, do you
> see a scenario in which this is likely to happen?
>
> I also want a sparse/partial checkout but I don't want
> the full submodule path.

This might not be as problematic as we think. If we do the same
sparse/partial checkout (what's the definition here?) with the <sha1
of tree/blob> as we do with the only <sha1 of commit> case and
consider the <sha1 of tree/blob> to be a _local_ (to the
super-project) shortcut. Then we only track the submodules using the
commit - local conflicts are easier to handle, git would refuse to
commit a <sha1 of tree/blob> not present in the commit tree.

We might even consider two object types:
module: <sha1 of commit> name
link: <sha1 of commit> <sha1 of tree/blob> name

