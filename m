From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: add options to enable/disable case folding
Date: Fri, 17 Apr 2015 11:44:00 -0700
Message-ID: <xmqqwq1appcf.fsf@gitster.dls.corp.google.com>
References: <xmqqoarclgnr.fsf@gitster.dls.corp.google.com>
	<1429271526-31234-1-git-send-email-mh@glandium.org>
	<55313B4B.3030106@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Apr 17 21:31:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjByz-0005Q4-9a
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 21:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbbDQTbR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Apr 2015 15:31:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51777 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752124AbbDQTbQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Apr 2015 15:31:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E10647D05;
	Fri, 17 Apr 2015 15:31:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gaj7+/mouizw
	KV7lGiGvamoBYLU=; b=MLHolFDUfVkI45gVXMgmbn4/wpFzX8Q5xwVdRwmLeoQy
	A0A9NA0a3i1+XpIPOZ6kW/90YTjh5RWoW/mqjUbWHUq62Bfn5Bdd2iHomTSNzIq4
	gKu2pE+UTWaDnO028V6uVNP33GKKFka4JFCuk2vdHLbHiMdH+KUWMdjuTz0ZAu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KXvpGE
	66tvoJVTTK3YtwooVifwvCTvgF7ngyt2Q+3a0iyisIhA1v6nvt0U1IAAMwOXz4t7
	l9hJJZMF7PdC+64A9izxB44OUd3HCx3V/HnofgSlt6ODjDtecj4ljSdkN7tjPf+H
	dYIn0mvIFObS4LB0ugm0E9kEooEblnIBbx2kg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0663447D04;
	Fri, 17 Apr 2015 15:31:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8164F4AA5B;
	Fri, 17 Apr 2015 14:44:02 -0400 (EDT)
In-Reply-To: <55313B4B.3030106@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Fri, 17 Apr 2015 18:56:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B7B3BF96-E531-11E4-A7D4-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267381>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> +--[no-]fold-case::
>> +	When files/directories with the same name but a different case
>> +	are detected, they are treated as the same (--fold-case) or as
>> +	being different (--no-fold-case). The default is --fold-case
>> +	when `core.ignorecase` is set to `true`, and --no-fold-case when
>> +	it is `false`.
>> +
> Most often the we use the term "ignore-case", could that be a better =
name ?
> Other opinions, pros/cons  ?

Yeah, --[no-]ignore-case sounds more in line with how other
commands' options are spelled.

But I somehow thought this "case-folding" was deliberately done as
an improvement against the original that did not have a way to do
the "ignore-case"?

http://thread.gmane.org/gmane.comp.version-control.git/200597/focus=3D2=
00625

I am not sure why not until now I did not find the original
justification dubious, but I think fast-export should never do case
folding---Joshua talks about working trees on a file system that is
incapable of expressing different cases, but "export" is about
reading in-repository histories, whose trees are fully capable of
expressing paths in different cases just fine, and spitting out a
file that can be processed by fast-import.  I do not see why it
should collapse two different paths that differ in case at export
time.

If the original history is broken by Perforce or whatever and
recording the history of the same path in different case
combinations in different commits, perhaps the right thing to do is
to fix the original history in Git repository before exporting in
the first place.

I do not see how such a corruption is related to the characteristics
of the filesystem where "export" is run.  Perhaps a case-insensitive
filesystem may helped Perforce to corrupt the history when initial
import of the history into Git was done, but core.ignorecase of the
current repository does not help us decide if that was actually the
case---the import may have been done on a completely different
machine.

So perhaps we should rip the case folding out altogether instead?
The entry for the change in the Release Notes may say:

 * "git fast-import" incorrectly case-folded the paths recorded in
   the history when core.ignorease is set (i.e. the repository's
   working tree is incapable of expressing paths that differ only in
   their cases); this old bug was reported in 2012 and was finally
   corrected.

or something like that?
