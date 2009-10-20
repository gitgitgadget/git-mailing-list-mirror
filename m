From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ident hash usage question
Date: Tue, 20 Oct 2009 15:30:06 -0700
Message-ID: <7vbpk1lmvl.fsf@alter.siamese.dyndns.org>
References: <76c5b8580910201024x58ffdd3bs6f4cc6932ac31868@mail.gmail.com>
 <81b0412b0910201116s694d7877rda872b368f1ae09a@mail.gmail.com>
 <81b0412b0910201119w7583487ag276cf964d0a85e@mail.gmail.com>
 <76c5b8580910201159i75a90f28pb882e83f0c7c40ae@mail.gmail.com>
 <81b0412b0910201219q4d16c472n43cab4b5d17cf63c@mail.gmail.com>
 <76c5b8580910201330r45cf625k3a41b5b9e24b3e01@mail.gmail.com>
 <7veioxn6ee.fsf@alter.siamese.dyndns.org>
 <76c5b8580910201514sc44f1cag222cf8a3710c875@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 00:30:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0NDn-0002rM-Om
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 00:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbZJTWaQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 18:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbZJTWaP
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 18:30:15 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38758 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750914AbZJTWaO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 18:30:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C0A8B7F48B;
	Tue, 20 Oct 2009 18:30:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pe3Xx6iXsHS7
	hAusYrU14yRmK2o=; b=bXfuAQO161qudjXXuZuTnIP7lDWsKGp5GNAgEQkgVoZZ
	4pWf5IaIqSqcu359TN1p14mcLYxddqMXUXh4h63ON9fHOzw4XhByDQ8g5jyzljQk
	aiyMYUwupjO4sn4SirvYWZRfQBA5sZrGuYkj0ah0EnARohy4XHnEF3co/xSvW9g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qK5h41
	fKXYK03idegIxfEtN/TD2yg2mNOQZuBWMCdeCruPqBRcU9THR0LAOdm5vv2t4LJV
	LlZNOzc+Cud0lVVuldenFSnOOdJvZIg6TCWc3vHBWtDo6ybjlU8iFdQHb1luFSgq
	zx8XrRNeVAYMCbrg1ZrWRJtzUPQtRJ/TwXcPo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9665F7F486;
	Tue, 20 Oct 2009 18:30:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C2AB67F481; Tue, 20 Oct 2009
 18:30:08 -0400 (EDT)
In-Reply-To: <76c5b8580910201514sc44f1cag222cf8a3710c875@mail.gmail.com>
 (Eugene Sajine's message of "Tue\, 20 Oct 2009 18\:14\:08 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 22FBC98E-BDC8-11DE-8000-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130861>

Eugene Sajine <euguess@gmail.com> writes:

>> If the project is already arranged to be compiled with decent automa=
tion,
>> I do not think you need any change to the workflow.
>>
>> You would have a version.cc file with
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0static char program_version[] =3D "My Pro=
gram " VERSION_STRING;
>>
>> in it, and teach the build procedure how to compile and link this fi=
le.
>> Something like:
>>
>> =C2=A0 =C2=A0version.o: version.cc
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0$(CXX) -o $@ -DVERSION_STRING=3D\""$(git =
describe HEAD)"\" $?
>>
>
> Please, correct me if I'm mistaken and forgive me if I'm not correct
> in using C++ terms.
>
> Your solution proposes to have a version file which will carry the
> info about last state the program was built from.
> But as I understand in case of static linking the executable will get
> only obj files from a library, which are necessary and everything
> irrelevant will be thrown away by linker.

I am not sure what you mean by "static linking" anymore.  Usually the w=
ord
means that everything you tell the linker to link to the executable is
linked, together with objects from libraries.  The resulting executable=
 is
usable on its own and it does not change behaviour regardless of which
version of dynamic libraries you depend on happen to be installed on th=
e
target system (because by definition a statically linked executable doe=
s
not depend on dynamic libraries---that is the whole point of static
linking).

So as long as you make sure version.o is linked to the final executable=
,
you will be fine.  One way to do so might be to have

	printf("Program version: %s", program_version);

at the beginning of main() ;-)

If your product ships as one main executable _dynamically_ linked with =
two
dynamic libraries, and all three components are built from the source
material under your source control, obviously you would need to make su=
re
that the above version.o or some equivalent of what embeds output from
"git describe HEAD" are linked to the main executable and to the two
libraries, but the idea is the same.
