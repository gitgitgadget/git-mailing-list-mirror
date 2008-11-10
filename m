From: drafnel@gmail.com
Subject: recognize loose local objects during repack
Date: Sun,  9 Nov 2008 23:59:55 -0600
Message-ID: <2390436.1226296705080.JavaMail.teamon@b307.teamon.com>
References: <7v8wrwidi3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, spearce@spearce.org, nico@cam.org, ae@op5.se
To: gitster@pobox.org
X-From: git-owner@vger.kernel.org Mon Nov 10 06:59:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzPoR-00015b-Ho
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 06:59:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbYKJF6c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 00:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbYKJF6c
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 00:58:32 -0500
Received: from www.teamon.com ([216.34.91.250]:4554 "EHLO b307.teamon.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751226AbYKJF6c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 00:58:32 -0500
Received: from b307.teamon.com (localhost [127.0.0.1])
	by b307.teamon.com (8.11.7 DSN_MOD/8.11.7) with ESMTP id mAA5wPo28391;
	Mon, 10 Nov 2008 05:58:25 GMT
X-Mailer: git-send-email 1.6.0.2.588.g3102
In-Reply-To: <7v8wrwidi3.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100490>


This was developed on top of the previous repack/pack-objects series.


Junio wrote:
> Presumably you meant "exclude objects accessible through alternates,
> either in packs or in loose form"?  If so then I think it is a good thing
> to have.


This patch set looks like what is necessary to exclude loose objects accessible
through alternates from packing.


> I think the useful kinds are only these five:
> 
>  - scoop loose objects that exist in local repository into a new pack,
>    without touching existing packs at all; exclude anything available in
>    any existing pack or in alternate repository (either loose or packed);

  repack -l

>  - pack everything that is needed by the local ref, except the ones that
>    are borrowed from alternate repositories (either loose or packed), into
>    a single new pack.  There are two variants of this: eject what is
>    currently packed but unnecessary into loose format when existing local
>    packs are replaced with the new pack, or lose them (i.e. -A).

  repack -a -l
  repack -A -l

>  - fatten local repository by packing everything that is needed by the
>    local ref into a single new pack, including things that are currently
>    borrowed from alternates.  There are two variants of this: eject what
>    is currently packed but unnecessary into loose format when existing
>    local packs are replaced with the new pack, or lose them (i.e. -A).

  repack -a
  repack -A

-brandon
