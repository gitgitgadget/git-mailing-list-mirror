From: Remi Vanicat <vanicat@debian.org>
Subject: Re: [BUG] git filter-branch failed to suppress a file with an accentuated letter in the filename
Date: Sat, 16 Feb 2008 07:34:29 +0100
Message-ID: <87tzk9tnnu.dlv@maison.homelinux.org>
References: <87bq6iw42w.dlv@maison.homelinux.org>
	<7vd4qygld8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Remi Vanicat <vanicat@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 07:35:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQGdr-00038T-JX
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 07:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752615AbYBPGeo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Feb 2008 01:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808AbYBPGeo
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 01:34:44 -0500
Received: from neuf-infra-smtp-out-sp604007av.neufgp.fr ([84.96.92.120]:37926
	"EHLO neuf-infra-smtp-out-sp604007av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752449AbYBPGen convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 01:34:43 -0500
Received: from neuf-infra-smtp-out-sp604001av.neufgp.fr ([84.96.92.125])
	by neuf-infra-smtp-out-sp604007av.neufgp.fr with neuf telecom
	id q46z1Y00E2iH3ss0706f00; Sat, 16 Feb 2008 07:34:40 +0100
Received: from maison.homelinux.org ([84.103.71.93])
	by neuf-infra-smtp-out-sp604001av.neufgp.fr with neuf telecom
	id q6aa1Y00A20lBGc0100000; Sat, 16 Feb 2008 07:34:40 +0100
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <moi@vanicat.homelinux.org>)
	id 1JQGd6-0000gx-9j; Sat, 16 Feb 2008 07:34:34 +0100
In-Reply-To: <7vd4qygld8.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 15 Feb 2008 09\:50\:11 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: moi@vanicat.homelinux.org
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on maison.homelinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=NO_RELAYS autolearn=ham
	version=3.2.3
X-SA-Exim-Version: 4.2.1 (built Tue, 21 Aug 2007 23:39:36 +0000)
X-SA-Exim-Scanned: Yes (on maison.homelinux.org)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74018>

Junio C Hamano <gitster@pobox.com> writes:

> Remi Vanicat <vanicat@debian.org> writes:
>
>> The culprit seem to be those line of filter-branch: (around line 279=
)=20
>> 		git diff-index -r $commit | cut -f 2- | tr '\012' '\000' | \
>> 			xargs -0 git update-index --add --replace --remove
>> git diff-index giving the filename as "foo/bar\303\251"
>
> I have to wonder in what century filter-branch was written ;-)
>
> Shouldn't those two lines be:
>
> 	git diff-index -r --name-only $commit |
>         git update-index --add --replace --remove --stdin

That solve the bug for me.
--=20
R=C3=A9mi Vanicat
