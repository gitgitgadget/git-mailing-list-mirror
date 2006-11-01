X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: Restore a single file in the index back to HEAD
Date: Wed, 1 Nov 2006 16:09:19 +0700
Message-ID: <fcaeb9bf0611010109t6281a120qeed21e0d3b29ad0c@mail.gmail.com>
References: <200610261641.11239.andyparkins@gmail.com>
	 <20061027073834.GC29057@spearce.org> <4541BE8E.5050605@op5.se>
	 <20061027081545.GF29057@spearce.org>
	 <81b0412b0610270245w6c29b3c3va7967991f53db298@mail.gmail.com>
	 <4541D670.6000900@op5.se> <7vac3igjpd.fsf@assigned-by-dhcp.cox.net>
	 <fcaeb9bf0610312358g1176e4d8q8962b08c2e8ff2c6@mail.gmail.com>
	 <7vpsc78ua3.fsf@assigned-by-dhcp.cox.net>
	 <7vvelz7eg2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 1 Nov 2006 09:09:49 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IzdmoR1mYTUpH1te0VfKJuft1Ta1QbOm+IsfnPR27R+dIC8CfRfqefSJZpqe33ptOmaYeYdRPgURdT6J7jSyYRqAFX08b/jOdKJktM/oUtTrQ7WNlMRkJBJZ70Z8qzRDmQ+PrnN5R9CtVkIWeE97ru6OwXpotDNnQjxDpA16UlM=
In-Reply-To: <7vvelz7eg2.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30627>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfC6A-0000B1-Rf for gcvg-git@gmane.org; Wed, 01 Nov
 2006 10:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1946714AbWKAJJX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 04:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423974AbWKAJJX
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 04:09:23 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:60018 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1423973AbWKAJJV
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 04:09:21 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1665736ugm for
 <git@vger.kernel.org>; Wed, 01 Nov 2006 01:09:20 -0800 (PST)
Received: by 10.78.157.8 with SMTP id f8mr8529510hue; Wed, 01 Nov 2006
 01:09:19 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Wed, 1 Nov 2006 01:09:19 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 11/1/06, Junio C Hamano <junkio@cox.net> wrote:
> Junio C Hamano <junkio@cox.net> writes:
>
> >> I would prefer "git update-index --reset frotz" or "git checkout
> >> --index HEAD frotz". git ls-tree|git update-index is too cryptic for
> >> me and too long for my fingers.
> >
> > Then perhaps you can use "git checkout HEAD frotz", which is the
> > simplest?
>
> Sorry, Oops.
>
> One should never respond to a message in an ancient thread
> unless one has enough time to revisit previous messages and
> refresh one's memory.
>
> The original topic was about updating the index entry without
> touching working tree, so "co HEAD path" would not do what was
> wanted.
>
> I think at the UI level, the most appropriate place would be
> "git reset".  Checkout is a Porcelainish that is primarily about
> working tree and it updates the index as a side effect (from the
> UI point of view); you can update the working tree without
> modifying index or you can update both index and the working
> tree, but updating only index and not working tree does not
> belong there.

Then perhaps git-reset should do "co HEAD path" too if --index is not specified?
To sum up:
 - git reset HEAD path -> git checkout HEAD path
 - git reset --index HEAD path -> git-ls-files HEAD path|git
update-index --index-info
 - git reset HEAD (without path) -> the current behaviour

Because  <commit-ish>  may be missing, there is some ambiguation here.
-- 
