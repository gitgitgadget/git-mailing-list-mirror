From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH v2 2/2] pack-objects: don't loosen objects available in
  alternate or kept packs
Date: Tue, 24 Mar 2009 18:01:03 -0500
Message-ID: <rQW7WJIjEMSgMCBHRTSMXJu2FmnvjGxMF8nC2pFnNro@cipher.nrlssc.navy.mil>
References: <ee63ef30903211526n47c40052mc40dc018f25c99fd@mail.gmail.com> <7vbpru9nh9.fsf@gitster.siamese.dyndns.org> <7viqm15qda.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 00:02:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmFe3-0002rE-B8
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 00:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753089AbZCXXBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 19:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752323AbZCXXBX
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 19:01:23 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47503 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbZCXXBX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 19:01:23 -0400
Received: by mail.nrlssc.navy.mil id n2ON14kf031058; Tue, 24 Mar 2009 18:01:04 -0500
In-Reply-To: <7viqm15qda.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 24 Mar 2009 23:01:03.0820 (UTC) FILETIME=[683640C0:01C9ACD4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114507>


Junio,

I notice this patch is in next now (I noticed earlier than today,
but haven't said anything).

I just want to point one minor thing.  After figuring out why last_found
was initialized to (void *)1 rather then NULL, you seem to have committed
a version that was slightly different from what I submitted.  The logic
is the same, but now the following line is different from the line in
sha1_file.c where I copied it from:

builtin-pack-objects.c (line 1952):

   p = (last_found != (void *)1) ? last_found : packed_git;

sha1_file.c (line 1931): 

   p = (last_found == (void *)1) ? packed_git : last_found;


People should be able to easily recognize the two procedures as "the same".
This small difference may give them pause.  If it is possible to amend
this commit before applying to master, perhaps you would like to do so.
Otherwise, no big deal.

-brandon
