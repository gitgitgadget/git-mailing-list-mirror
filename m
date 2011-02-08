From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] cache-tree: do not cache empty trees
Date: Mon, 7 Feb 2011 22:30:00 -0600
Message-ID: <20110208043000.GA6375@elie>
References: <1296899427-1394-1-git-send-email-pclouds@gmail.com>
 <1296914835-808-1-git-send-email-pclouds@gmail.com>
 <20110207091740.GA5391@elie>
 <20110207095713.GA19653@do>
 <7v1v3jvaef.fsf@alter.siamese.dyndns.org>
 <AANLkTim_G9cPs=+1GQ2qBEgriOyKYgXk17iHE4oq9h2C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jakub Narebski <jnareb@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Yann Dirson <dirson@bertin.fr>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 05:30:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmfDX-0003Vs-5o
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 05:30:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923Ab1BHEaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 23:30:11 -0500
Received: from mail-yi0-f46.google.com ([209.85.218.46]:46721 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab1BHEaK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 23:30:10 -0500
Received: by yib18 with SMTP id 18so2052643yib.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 20:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Alb1Nb0sKSJ4qjmjhrL6WTfgsUbRmYJO748Lz1EfB8g=;
        b=xdpUByXMYXrlW6C17r858u9AkwaGr5F4OAFJtlBSVJA6/SzhbMVyMFED6yh7/rGMKE
         M7G0Prj1Epw/z6EarNrtO5Gfvs8DaTnenSjrcOo7MVexTzRhtgIwm+P1ssHHlz9tcECp
         vasuZo1IFvIUD3aSmVnedO31uqZuq2+wUgMcM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JszNVSjLjmfk+UqZEaOvEWo+l/sjJCJfMD+zryCNZ6FUgMjWJNuE54f/OLNlQBTWo3
         ZEQun40kmhWqyiRP3Nwmb0v8QMOTUk34ciJs73d8aZVwJrg989MxKm5xCo7R/ubT4z/S
         eY4BCg28NaiwoCYCyaRZQVjN571eRzT/Sjsp0=
Received: by 10.150.197.5 with SMTP id u5mr3924295ybf.293.1297139409509;
        Mon, 07 Feb 2011 20:30:09 -0800 (PST)
Received: from elie ([76.206.235.233])
        by mx.google.com with ESMTPS id v8sm1768478yba.14.2011.02.07.20.30.05
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 20:30:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTim_G9cPs=+1GQ2qBEgriOyKYgXk17iHE4oq9h2C@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166332>

Nguyen Thai Ngoc Duy wrote:

> But empty trees are allowed in repo since 79b1138 (fsck.c: fix bogus
> "empty tree" check). Index can't handle empty trees, so it's a bug to
> me that index still accepts them as input and silently discard them.

FWIW my instinct points in the opposite direction.  I wouldn't mind
seeing fsck warn about trees containing empty subtrees[1].  As for
cache-tree, while it is not obvious what the right thing to do is,
discarding empty subtrees sounds accepatable.

For storage of empty subtrees in repos imported from svn, Yann's idea
of using .gitattributes somehow (maybe in the parent directory or
maybe in the subdir itself) seems oddly appealing.

Just my unproductive two cents,
Jonathan

[1] I suspect 79b1138 was only meant to deal with the "git commit
--allow-empty from newly initialized repo" case.
