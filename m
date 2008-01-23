From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 23 Jan 2008 13:19:45 -0800
Message-ID: <7vve5kgrym.fsf@gitster.siamese.dyndns.org>
References: <478E1FED.5010801@web.de>
	<7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org>
	<alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org>
	<B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org>
	<alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org>
	<8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
	<alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org>
	<B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com>
	<alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org>
	<478F99E7.1050503@web.de>
	<alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org>
	<F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org>
	<alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org>
	<Pine.LNX.4.64.0801181114430.817@ds9.cixit.se>
	<alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org>
	<7vr6gedgk9.fsf@gitster.siamese.dyndns.org>
	<m17ii1fecy.fsf@ebiederm.dsl.xmission.com>
	<7vsl0pp7u5.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801230923450.22568@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 22:20:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHn1P-0007gI-Ld
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 22:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbYAWVUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 16:20:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbYAWVUF
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 16:20:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbYAWVUD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 16:20:03 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D8FA642E6;
	Wed, 23 Jan 2008 16:19:59 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 213DC42DD;
	Wed, 23 Jan 2008 16:19:47 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801230923450.22568@xanadu.home> (Nicolas
	Pitre's message of "Wed, 23 Jan 2008 09:26:06 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71572>

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 22 Jan 2008, Junio C Hamano wrote:
>
>> ebiederm@xmission.com (Eric W. Biederman) writes:
>> 
>> > Random thought.  Would it make sense to implement a git paranoid
>> > mode to autodetect name mangling.
>> >
>> > I.e.  After opening or creating a file by name we do a readdir in the
>> > same directory to make certain we can find that same name/inode
>> > combination.  Then on name-mangling systems we can autodetect they
>> > exist and limit ourselves to just what they don't mangle with no
>> > prior knowledge.  By refusing to process names that actively
>> > get mangled.   For small directories that you frequently see in
>> > development it shouldn't even be that slow.
>> 
>> Inside init-db where we already check how the filesystem
>> behaves, we could have an autodetection.
>
> I wonder if that is good enough.  Git repositories can be copied over to 
> different filesystems.

Do you mean "cp -a"?  If I am not mistaken we already have that
issue, due to core.filemode, when user does that across
filesystems with different behaviours.

There is not much we can do against "cp -a" other than telling
users that some configurations need to be adjusted.
