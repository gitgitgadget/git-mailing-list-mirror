From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Tue, 22 Jan 2008 19:46:37 -0700
Message-ID: <m17ii1fecy.fsf@ebiederm.dsl.xmission.com>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201>
	<65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org>
	<200801162251.54219.jnareb@gmail.com>
	<1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org>
	<alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 03:48:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHVfD-00031h-G4
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 03:48:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbYAWCsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jan 2008 21:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752876AbYAWCsA
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jan 2008 21:48:00 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:54872 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708AbYAWCr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jan 2008 21:47:59 -0500
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.14.1/8.14.1/Debian-9) with ESMTP id m0N2l86q015265;
	Tue, 22 Jan 2008 19:47:09 -0700
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.14.1/8.14.1/Submit) id m0N2kbK9015246;
	Tue, 22 Jan 2008 19:46:37 -0700
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
In-Reply-To: <7vr6gedgk9.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 18 Jan 2008 12:28:22 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71497>

Junio C Hamano <gitster@pobox.com> writes:

> I'd rather see our mental bandwidth spent on coming up with a
> workable workaround for such broken filesystems, while not
> hurting use of git on sane platforms.
>
> I fear it might have to end up to be very messy and slow,
> though.

Random thought.  Would it make sense to implement a git paranoid
mode to autodetect name mangling.

I.e.  After opening or creating a file by name we do a readdir in the
same directory to make certain we can find that same name/inode
combination.  Then on name-mangling systems we can autodetect they
exist and limit ourselves to just what they don't mangle with no
prior knowledge.  By refusing to process names that actively
get mangled.   For small directories that you frequently see in
development it shouldn't even be that slow.

Eric
