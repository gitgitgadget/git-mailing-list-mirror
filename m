From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Define a version of lstat(2) specially for copy operation
Date: Wed, 18 Mar 2009 08:22:24 +0100
Message-ID: <81b0412b0903180022w4b95106ds54a16a835b53c1d@mail.gmail.com>
References: <81b0412b0903170926p4f2d536el2b96a71c79c0159e@mail.gmail.com>
	 <7vprggqeh2.fsf@gitster.siamese.dyndns.org>
	 <49BFD6DD.1010800@viscovery.net>
	 <20090317202818.GA13458@blimp.localdomain>
	 <7v63i7ridk.fsf@gitster.siamese.dyndns.org>
	 <20090317213820.GC13458@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, Jeff King <peff@peff.net>,
	layer <layer@known.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 18 08:24:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljq85-0004k4-JG
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 08:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbZCRHW2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Mar 2009 03:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751803AbZCRHW2
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 03:22:28 -0400
Received: from mail-ew0-f168.google.com ([209.85.219.168]:49720 "EHLO
	mail-ew0-f168.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbZCRHW1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2009 03:22:27 -0400
Received: by ewy12 with SMTP id 12so315110ewy.37
        for <git@vger.kernel.org>; Wed, 18 Mar 2009 00:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WvX+HPjjQditldimJ9W/s0WGGW531yonTjKBfggAvjs=;
        b=wG+zXXUbQzKnHDOrHGdvA5K00gX3635O5NhoLgl/jj/eNtZyo9PpyYiBHFhONi+gHW
         8fNCT0YjC4b0L3QWA6nlsAxfbq4IzQBKejViSaYZM2ZodUdBApHPDt/aXrjxIyZnZfAp
         4arjlH1whlCGelCrFwWVSv9yGSuIwa1BTlano=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Lth8FtDUpdd3lQyCqOtG8hDN93HXpXWQePD60PaU6reYyao8r8hLuacQ4H4Kkvl1Zd
         LxJhOMVCeXbPpzm4tmFxPtnLznxRGIMWMe7leAu6mGRb2XEt0oLEUVF6zFaS9T/B3mJq
         Fa5Hg2RPjOZmBf3Csg6hmYZMmRAT710AYfLCs=
Received: by 10.210.91.7 with SMTP id o7mr5211156ebb.39.1237360944383; Wed, 18 
	Mar 2009 00:22:24 -0700 (PDT)
In-Reply-To: <20090317213820.GC13458@blimp.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113592>

2009/3/17 Alex Riesen <raa.lkml@gmail.com>:
>> hooks copied from templates? =C2=A0I think we could pass mode 0 to c=
opy_files()
>> and have the function special case it (and allow a platform specific
>> copy_files() implemented by Cygwin). =C2=A0lstat() in the copy_templ=
ates_1()
>> codepath is primarily done to see if we need to descend into a direc=
tory
>> or symlink() and our use of st.st_mode to pass to copy_files() is a =
no
>> cost side effect on platforms with x-bit support.
>
> And I don't think that the platform broken in so many ways deserves
> that kind of treatment. Maybe this patch is enough. Will test it
> tomorrow, when I get to mine so much hated Windows system.
>

Ok, I just tested it and it works. Junio, this patch can replace the pr=
evious
change which disabled the test.
