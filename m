From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: getting list of objects for packing
Date: Fri, 31 Oct 2008 16:40:03 -0500
Message-ID: <fAUegZ3bxPo8HquZjUM9syW-giYefuAzBtb1XXHQ-TwbmvJvMZvmDA@cipher.nrlssc.navy.mil>
References: <TtAUShKh7lOR5rkf1iyWwpMOWoYpT8Mnw-t3Wemdy3tTCd0XiQHdag@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0810311625450.13034@xanadu.home> <JhY9the71dfsAJuojZF2S4BG-SEkshM7XxIWGPBeY9M@cipher.nrlssc.navy.mil> <7v7i7o8nc5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 22:41:59 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw1kk-0000mN-Uj
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 22:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbYJaVka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 17:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753504AbYJaVk3
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 17:40:29 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:36447 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbYJaVk2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 17:40:28 -0400
Received: by mail.nrlssc.navy.mil id m9VLe3CD020573; Fri, 31 Oct 2008 16:40:03 -0500
In-Reply-To: <7v7i7o8nc5.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 31 Oct 2008 21:40:03.0666 (UTC) FILETIME=[3BD99B20:01C93BA1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99650>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> 
>> Nicolas Pitre wrote:
>>> On Fri, 31 Oct 2008, Brandon Casey wrote:
>>>>   -The sed statement is stripping off anything after the sha1. Any way to
>>>>    get rev-list to print out just the sha1 so that sed is not necessary?
>>> If you strip the data after the SHA1 when pipping into pack-objects then 
>>> you'll have horrible delta compression results.  The path names after 
>>> each SHA1 is used to sort objects when trying to find best matches for 
>>> delta compression. So you should preserve those and feed it back 
>>> especially with those packs that you still want delta compression for.
>> Ah, I'll have to rethink my script then. Thanks!
> 
> Yeah, but wasn't the purpose of your whole exercise to list objects that
> do not delta nor compress well with each other, in which case the delta
> compression order (aka name hash) would not matter, no?

The script I wrote actually starts up two pack-objects instances and I was
writing the objects I wanted to pack _normally_ to one, and the ones that I
did not want compressed/deltafied to the other (which was started with
--no-reuse-object --window=0 --depth=0 --compression=0).

I didn't mentioned that fact in my first email, but I'm very glad Nico
made his point.

-brandon
