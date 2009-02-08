From: Nigel Magnay <nigel.magnay@gmail.com>
Subject: Re: [PATCH JGIT] Minor : Make ObjectId, RemoteConfig Serializable
Date: Sun, 8 Feb 2009 13:26:19 +0000
Message-ID: <320075ff0902080526g2bee8188g395397b06a0c80ee@mail.gmail.com>
References: <320075ff0902060702n7573aaecu9054626ee9a6991@mail.gmail.com>
	 <320075ff0902061315g3f8b9c9bj92f528e700d59c50@mail.gmail.com>
	 <200902080313.21785.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git ML <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sun Feb 08 14:27:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW9hN-0000Xx-Fk
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 14:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbZBHN0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 08:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752796AbZBHN0W
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 08:26:22 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:33937 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbZBHN0V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 08:26:21 -0500
Received: by fxm13 with SMTP id 13so2121283fxm.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 05:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=mHGbzRHJ2Qtum8u/Yo96SbgPLHBhhgIVObKkE3Dnq0s=;
        b=IofPXHQv3z2jQEe/02Cgahr+ICXLePmlR+DkHkbTx2nHM9xDjxTr0xcnjbMo48eNGQ
         DSL/gHjCumIrBOv05whCb9/7QggxiXTcKufouMhA4dtXanTRjc4ByYYkRKQo8i7xz7Bt
         akVfQgalipJRM4QFswQI3zkxrAhmh1esW2X5E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TKeHxkW9mFfMZN1gBhK08As0w9xMLrVbsgZIv4GY52mVgi6HZdbkl6g3UNPFYSS021
         lhzRCGI0RmPlNPrcXjszO07/Obd8sNXchToIl3Di4NL6y+KcS2y1KHBae9hyeuEGyCl6
         syyga9UEO9fB58DhDN4RHVA+Kkf860TKb8gPA=
Received: by 10.103.49.12 with SMTP id b12mr349927muk.81.1234099579609; Sun, 
	08 Feb 2009 05:26:19 -0800 (PST)
In-Reply-To: <200902080313.21785.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108975>

> A problem (big problem) with serialization is that it often leads to
> fragile interfaces. One might want to have precise control over
> the serialization so a change in the implementation doesn't affect
> compatibility. Serializing AnyObjectId should not depend on the
> implementation de jour. Second, how do we handle subclasses?
>
> But maybe leaving it this way would be our way of saying that
> the interface may break at any time, promise.
>


Well, we can of course implement writeObject / readObject (or do so
if/when compatibility breaks, and it's cared about)

That's how I tend to view it anyway (may break at any time) - you
can't just update a jar library to a significantly new version and
expect it all to stay compatible. Also for half my use, it's not for
persistence, it's for transferring over the wire to a slave process.

Thinking a bit more clearly, I probably don't need AnyObjectId, just
ObjectId - but I've also missed RefSpec and URIish as they're used in
RemoteConfig..
