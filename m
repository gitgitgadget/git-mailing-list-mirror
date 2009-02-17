From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: not all tests pass when on an NFS partition
Date: Tue, 17 Feb 2009 10:32:23 -0600
Message-ID: <UeTsTvDfFT9ToLdKosYcgFRx4HzMKUFpn67jts4q-qNPzYZVyG8DQQ@cipher.nrlssc.navy.mil>
References: <3a69fa7c0902121220n4ea2f19di6fe984dd2002772@mail.gmail.com> <7vk57vjqsd.fsf@gitster.siamese.dyndns.org> <Aq-rucZsypJQU8SHtTE8X62cEZZn-xSpOOIfA-I5czdtCkm2IyMjDw@cipher.nrlssc.navy.mil> <3a69fa7c0902151219y270681f7r17a108fdf44213ad@mail.gmail.com> <3a69fa7c0902170641m2ba9b8aeo950c9e3868ba6244@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: E R <pc88mxer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 17:34:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZStX-0006rW-EB
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 17:34:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753371AbZBQQcb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 11:32:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753255AbZBQQcb
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 11:32:31 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55968 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbZBQQca (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 11:32:30 -0500
Received: by mail.nrlssc.navy.mil id n1HGWNdr020951; Tue, 17 Feb 2009 10:32:23 -0600
In-Reply-To: <3a69fa7c0902170641m2ba9b8aeo950c9e3868ba6244@mail.gmail.com>
X-OriginalArrivalTime: 17 Feb 2009 16:32:23.0667 (UTC) FILETIME=[4FDC0C30:01C9911D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110407>

E R wrote:
> Btw - what kind of risks are involved in using git when test
> t5304-prune.sh doesn't pass? Do we risk repository corruption?

For the case in the test, git-prune is failing to remove an object
that it should, which won't cause repo corruption.  It will just
cause retention of an object for longer than it is needed. I suspect
this is caused by some flaw in the NFS client (disclosure: IANAKH).

In practice, I don't think you'll experience this flaw.  I think it
shows up in the test because we are manually adjusting the mtime of
the objects and then immediately trying to prune them and this must
tweak whatever code has a bug.

I have been using git on 5.2 for a couple of months now with no problem.
Admittedly, prune is a rare operation, usually triggered by git-gc.

-brandon
