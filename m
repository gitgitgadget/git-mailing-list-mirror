From: Hin-Tak Leung <hintak.leung@gmail.com>
Subject: Re: git gc expanding packed data?
Date: Sat, 8 Aug 2009 14:05:22 +0100
Message-ID: <3ace41890908080605k4ec6661bmcb4c87e10bc5fd87@mail.gmail.com>
References: <m2tz0j154o.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Aug 08 15:05:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZlc3-0007AE-Lf
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 15:05:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934148AbZHHNFX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Aug 2009 09:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934145AbZHHNFX
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Aug 2009 09:05:23 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:58988 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934137AbZHHNFW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Aug 2009 09:05:22 -0400
Received: by ewy10 with SMTP id 10so2082151ewy.37
        for <git@vger.kernel.org>; Sat, 08 Aug 2009 06:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9SPEXvrjtsddmoK1yZGoHGLXf1m0H9CI1q5aELyYaN0=;
        b=PKjMqenhcjmsLglCPCDPbtSd2d4bNaVjRdNa5/wS70LnhomkM8dtVtr43k7yiQisWO
         CFx56WlxjqVjriZnvxHOsGlEZllGNSfaNZe22qMW+gCimgsB7ITIQ+XwRHTGnoXSitUO
         p5jOVqw6M7eU9w6s/B/RBZq7AxRiVEsFk1lpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kegIKfd/k6mwa9NyMv2MB0qhtEu5O5ztfLuKzXvMBLxGlD4MjnnrucHpjDgyuU45zR
         W605WPZuJZs4EAU4p5dGq2llKj3HaY787sXyI2OJyUWur/Eua/h/9/MYZl+5xlDWhSyP
         iOdWfdA1rpGZz2NmR+euxn3QuNunpKE2UGa8s=
Received: by 10.216.87.140 with SMTP id y12mr498652wee.4.1249736722266; Sat, 
	08 Aug 2009 06:05:22 -0700 (PDT)
In-Reply-To: <m2tz0j154o.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125276>

On Sat, Aug 8, 2009 at 2:11 AM, Andreas Schwab<schwab@linux-m68k.org> w=
rote:
> Nicolas Pitre <nico@cam.org> writes:
>
>> It appears that the git installation serving clone requests for
>> git://gcc.gnu.org/git/gcc.git generates lots of unreferenced objects=
=2E I
>> just cloned it and the pack I was sent contains 1383356 objects (can=
 be
>> determined with 'git show-index < .git/objects/pack/*.idx | wc -l').
>> However, there are only 978501 actually referenced objects in that
>> cloned repository ( 'git rev-list --all --objects | wc -l'). =A0That=
 makes
>> for 404855 useless objects in the cloned repository.
>
> Those objects are not useless. =A0They are referenced by the remote r=
efs
> on the remote side, which are not fetched by default. =A0If you clone=
 a
> mirror of the repository you'll see no unreferenced objects.
>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 58CA 54C7 6D53 942B 1756 =A001D3 44D5 214B 82=
76 4ED5
> "And now for something completely different."
>

Thanks... It is a difference between svn and git mentality probably -
one only pushes reasonably reliable code to a public git repository,
whereas anything transient is recorded in svn - I think many of the
unreferenced objects are svn user-branches (which are probably of use
to people who intend to work on gcc for fairly extended periods,
rather than casual users like me).
The case with gcc is probably quite extreme - many user branches, and
very large code base - but is there anything on the git side with git
gc which can lessen this kind of pathological behavior (expanding
packs)?

Thanks a lot for the explanation and the discussion.

Hin-Tak
