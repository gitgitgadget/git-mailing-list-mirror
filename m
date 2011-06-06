From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/6] git: please honor DNS SRV records
Date: Mon, 6 Jun 2011 04:49:36 -0500
Message-ID: <20110606094936.GL8015@elie>
References: <20110524202249.GA5889@elie>
 <20110524230900.GA9440@radis.liafa.jussieu.fr>
 <20110606093019.GD8015@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Julien Cristau <jcristau@debian.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 11:49:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTWRT-00077Z-0B
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 11:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755652Ab1FFJtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 05:49:46 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:54637 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545Ab1FFJtp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 05:49:45 -0400
Received: by iwn34 with SMTP id 34so2975868iwn.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 02:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=0HQZ5l32PWZKJzeVoHSNYYhuaEkhUVcK2r3wT6yc34s=;
        b=ee++RDhHm4zuIpFwYnhW9qdaZ8tsX7tPdeKJOpPYkq9Xh5lD0VMIG9g+6R4zFf+CDT
         fKXpAOZ3ee/thB/omVNTWwwqWDXTTuocBwqtbkl7DvySZE7cboWinPDnlP5MirhNORef
         f3y8T0bSwSOWsBcxgotC19tlOUyobcFvMwZiA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dpVQLbfic0jVzu6iYxMdK93wKiOUtK+Kkb30GegTsfkiWLh+C1GXVbiXBPYzFBEoaN
         JmD2dYEAfDXihctj15fg02wQsVQGFLXuOJEyXcFDhx4CFTzE3clCJFNAwLIkwyrEAVBq
         dvhabqDYcbVZWy2bmTwErhZDoV0bKv6fQlar0=
Received: by 10.43.54.193 with SMTP id vv1mr8540068icb.338.1307353784544;
        Mon, 06 Jun 2011 02:49:44 -0700 (PDT)
Received: from elie ([68.255.97.40])
        by mx.google.com with ESMTPS id ex14sm2660239icb.1.2011.06.06.02.49.40
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 02:49:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110606093019.GD8015@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175113>

Jonathan Nieder wrote:

> Does the general idea seem sane?

Here's a diffstat for the curious.

Jonathan Nieder (6):
  transport: expose git_tcp_connect and friends in new tcp.h
  daemon: make host resolution into a separate function
  daemon: move locate_host to tcp.c
  transport: fix index in ipv6 connection failed message
  tcp: unify ipv4 and ipv6 code paths
  transport: learn to honor DNS SRV records

 Makefile   |   17 ++++
 connect.c  |  270 +-------------------------------------------------------
 daemon.c   |   54 +----------
 dns-ipv4.c |   33 +++++++
 dns-ipv4.h |   65 ++++++++++++++
 dns-ipv6.c |   45 +++++++++
 dns-ipv6.h |   31 +++++++
 srv.c      |  290 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 srv.h      |   15 +++
 tcp.c      |  236 ++++++++++++++++++++++++++++++++++++++++++++++++
 tcp.h      |   11 +++
 11 files changed, 749 insertions(+), 318 deletions(-)
 create mode 100644 dns-ipv4.c
 create mode 100644 dns-ipv4.h
 create mode 100644 dns-ipv6.c
 create mode 100644 dns-ipv6.h
 create mode 100644 srv.c
 create mode 100644 srv.h
 create mode 100644 tcp.c
 create mode 100644 tcp.h
