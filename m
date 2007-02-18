From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Add `struct object_hash`
Date: Sun, 18 Feb 2007 17:48:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702181740100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702171838150.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vtzxjj24j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Mike Coleman <tutufan@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 17:48:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIpDb-0001AO-NT
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 17:48:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbXBRQsw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 11:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbXBRQsw
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 11:48:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:51408 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751444AbXBRQsw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 11:48:52 -0500
Received: (qmail invoked by alias); 18 Feb 2007 16:48:50 -0000
X-Provags-ID: V01U2FsdGVkX19KgIsWec9KONnd0KXK4BPw+Xgdv5UQhnhEtlmYql
	LTyw==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vtzxjj24j.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40078>

Hi,

These are only minor nits, as I think your code is bug free.

On Sun, 18 Feb 2007, Junio C Hamano wrote:

> +static void insert_object_into_hash(struct object_hash_entry *ent, struct object_hash *hash)

I'd rather _not_ name it "ent", as that has a different meaning already.

Also, what is your preferred width? Your line is way longer than 80 
columns.

> +static void grow_object_hash(struct object_hash *hash)
> +{
> +	struct object_hash_entry **old_hash = hash->hash;
> +	int i;
> +	int old_size = hash->size;
> +	int new_size = (old_size + 1000) * 3 / 2;
> +
> +	hash->hash = xcalloc(new_size, sizeof(struct object_hash_entry *));
> +	hash->size = new_size;

Either have a "new_hash" variable, or get rid of "new_size".

BTW I just tried to convert obj_hash to this interface, and it seems that 
there really is no elegant way (without wasting memory; You could do it, 
but then you'd have _two_ pointers for each object: one to the 
object_hash_entry, and from _that_ to the object). Maybe you have a clever 
way to solve this?

Ciao,
Dscho
