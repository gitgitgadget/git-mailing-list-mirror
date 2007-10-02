From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: metastore
Date: Tue, 2 Oct 2007 23:15:18 +0200
Message-ID: <20071002211518.GA10445@hardeman.nu>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0709151430040.5298@iabervon.org> <20070916060859.GB24124@piper.oerlikon.madduck.net> <20070919191607.GE13683@hardeman.nu> <20071002195301.GB14171@lapse.madduck.net> <20071002195816.GA6759@hardeman.nu> <85lkalz3iv.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 02 23:14:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icp47-00012x-8E
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 23:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755327AbXJBVNs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Oct 2007 17:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755303AbXJBVNs
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 17:13:48 -0400
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:56935 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755266AbXJBVNr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Oct 2007 17:13:47 -0400
Received: from ip54532fb6.speed.planet.nl ([84.83.47.182] helo=austin)
	by palpatine.hardeman.nu with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <david@hardeman.nu>)
	id 1Icp3a-0006C6-Vj; Tue, 02 Oct 2007 23:13:31 +0200
Received: by austin (Postfix, from userid 1000)
	id 72EEB29000A; Tue,  2 Oct 2007 23:15:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <85lkalz3iv.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59742>

On Tue, Oct 02, 2007 at 10:04:56PM +0200, David Kastrup wrote:
>David H=E4rdeman <david@hardeman.nu> writes:
>
>> On Tue, Oct 02, 2007 at 08:53:01PM +0100, martin f krafft wrote:
>>>also sprach David H=E4rdeman <david@hardeman.nu> [2007.09.19.2016 +0=
100]:
>>>> But I agree, if any changes were made to git, I'd advocate adding
>>>> arbitrary attributes to files (much like xattrs) in name=3Dvalue
>>>> pairs, then any extended metadata could be stored in those
>>>> attributes and external scripts/tools could use them in some way
>>>> that makes sense...and also make sure to only update them when it
>>>> makes sense.
>>>
>>>So where would those metdata be stored in your opinion?
>>
>> I'm not sufficiently versed in the internals of git to have an
>> informed opinion :)
>
>I think we have something like a length count for file names in index
>and/or tree.  We could just put the (sorted) attributes after a NUL
>byte in the file name and include them in the count.  It would also
>make those artificially longer file names work more or less when
>sorting them for deltification.

Or perhaps the index format could be extended to include a new field fo=
r=20
value=3Dname pairs instead of overloading the name field.

But as I said, I have no idea how feasible it would be to change git to=
=20
support another arbitrary length field in the index/tree file.

>However, this requires implementing _policies_: it must be possible to
>specify per repository exactly what will and what won't get tracked,
>or one will get conflicts that are not necessary or appropriate.

I think the opposite approach would be better. Let git provide=20
set/get/delete attribute operations and leave it at that. Then external=
=20
programs can do what they want with that data and add/remove/modify tag=
s=20
as necessary (and also include the smarts to not, e.g. remove the=20
permissions on all files if the git repo is checked out to a FAT fs).

--=20
David H=E4rdeman
