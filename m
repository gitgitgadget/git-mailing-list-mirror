From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/9] Completely move out worktree setup from
 setup_git_directory_gently()
Date: Wed, 27 Feb 2008 19:37:37 -0800
Message-ID: <7vk5kplpj2.fsf@gitster.siamese.dyndns.org>
References: <cover.1204130175.git.pclouds@gmail.com>
 <20080227163934.GA28084@laptop> <7vy795lt89.fsf@gitster.siamese.dyndns.org>
 <fcaeb9bf0802271931t559d4bd1n86bb5c644b082274@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 04:38:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUZbH-0006vf-2h
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 04:38:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906AbYB1Dhu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Feb 2008 22:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752735AbYB1Dhu
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 22:37:50 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49647 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723AbYB1Dht convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Feb 2008 22:37:49 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3974D2ED0;
	Wed, 27 Feb 2008 22:37:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 676962ECE; Wed, 27 Feb 2008 22:37:42 -0500 (EST)
In-Reply-To: <fcaeb9bf0802271931t559d4bd1n86bb5c644b082274@mail.gmail.com>
 (Nguyen Thai Ngoc Duy's message of "Thu, 28 Feb 2008 10:31:01 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75346>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On Thu, Feb 28, 2008 at 9:17 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes=
:
>>
>>  > -     prefix =3D setup_git_directory_gently(&nongit);
>>  > -     init_revisions(&rev, prefix);
>>  > +     setup_git_directory_gently(&nongit);
>>  > +     init_revisions(&rev, NULL);
>>
>>
>>
>> > @@ -233,19 +233,20 @@ int cmd_diff(int argc, const char **argv, co=
nst char *prefix)
>>  > ...
>>
>> > -     init_revisions(&rev, prefix);
>>  > +     init_revisions(&rev, NULL);
>>
>>  Hmm.  How is the effect of this change compensated later to give
>>  proper prefix value to rev.diffopt.prefix?
>>
>
> I assume you meant rev.prefix? rev.prefix is set right before
> setup_revisions(). (grr.. I think I left an redundant
> rev.diffopt.skip_stat_unmatch assignment)

I did mean rev.diffopt.prefix that is initialized by the last
four lines in init_revisions() from the value of prefix you
pass.
