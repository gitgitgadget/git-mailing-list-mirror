X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Submodules in GIT
Date: Mon, 4 Dec 2006 12:12:55 +0100
Message-ID: <200612041212.55911.Josef.Weidendorfer@gmx.de>
References: <20061130170625.GH18810@admingilde.org> <20061203221630.GA940MdfPADPa@greensroom.kotnet.org> <Pine.LNX.4.64.0612031421030.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 4 Dec 2006 11:13:19 +0000 (UTC)
Cc: skimo@liacs.nl, sf <sf-gmane@stephan-feder.de>,
	git@vger.kernel.org, Martin Waitz <tali@admingilde.org>,
	sf <sf@b-i-t.de>, Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0612031421030.3476@woody.osdl.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33188>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrBl3-0003qU-9M for gcvg-git@gmane.org; Mon, 04 Dec
 2006 12:13:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935968AbWLDLNA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 06:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935970AbWLDLNA
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 06:13:00 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:6374 "EHLO
 mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP id
 S935968AbWLDLM7 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 06:12:59 -0500
Received: from dhcp-3s-49.lrr.in.tum.de (dhcp-3s-49.lrr.in.tum.de
 [131.159.35.49]) by mail.in.tum.de (Postfix) with ESMTP id 373E2284C; Mon,  4
 Dec 2006 12:12:58 +0100 (MET)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Sunday 03 December 2006 23:32, Linus Torvalds wrote:
> So a particular instance of a submodule might be "aware" of the fact that 
> it's a submodule of a supermodule. For example, the "awareness" migth be 
> as simple as just a magic flag file inside it's .git/ directory. And that 
> awareness would be what simply disabled pruning or "repack -d" within that 
> particular instance.

That prohibits the problem in your supermodule and your instance of the
given submodule.

But IMHO, using a submodule commit which could be removed by pruning in
another instance of the submodule is really not the thing you ever want.
If you start your own branch in a submodule, and start to rely on it in
the supermodule, you _will_ want to push this to the submodule upstream.

And if you find that you have to rebase in the submodule, you simply
have to rewrite your branch commits in the supermodule too. Otherwise,
you effectively fork the submodule project purely for your superproject.

So I suppose that in practical use, pruning in submodules probably
would not have any negative effect. If it has, you made something
wrong. So you probably should only a submodule commit if it has
"publishing quality" (unless being on a temporary supermodule branch).

Ie. any "borrowers" file should be empty.

