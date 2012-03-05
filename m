From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 03/10] cat-file: use streaming interface to print blobs
Date: Mon, 5 Mar 2012 09:42:16 +0700
Message-ID: <CACsJy8BFW_LhsoL_ickLopnnMBj10rn-9QcoqmXML8Uau74S5A@mail.gmail.com>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
 <1330865996-2069-1-git-send-email-pclouds@gmail.com> <1330865996-2069-4-git-send-email-pclouds@gmail.com>
 <7vling6jw2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 03:42:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Nsz-0000Bb-Mi
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 03:42:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754915Ab2CECmt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 21:42:49 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:59693 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228Ab2CECms convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Mar 2012 21:42:48 -0500
Received: by wejx9 with SMTP id x9so2056635wej.19
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 18:42:47 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.216.134.205 as permitted sender) client-ip=10.216.134.205;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.216.134.205 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.216.134.205])
        by 10.216.134.205 with SMTP id s55mr3077291wei.100.1330915367730 (num_hops = 1);
        Sun, 04 Mar 2012 18:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=MuMiEysQ9ZV5liIJh+P1tBGB0Ha2kantqyNaCxPdC/k=;
        b=e54hG+s4VbiTgp1DZSP9C9YHzQn4IHycEZAUXyNHO8QaAHMCbIX2CqQFDmNp1XVmi8
         XKSB+YLVPcV2o4aGq6Qv9AQL/tM6Ho6rEvnhEi+6YQKSkoj2XZE8gsH8FzaC/EC+7GYf
         fX/gfROtGGB3s4x8hE3GbrqlT7osGjlFI6ShZ0u8vuAsVmGO+K2u+gNybCutqliM4JfW
         cYqio4+rQixy9wWNhzhsn7P4JdXtMLDZqSrEJfBE+0KWeMrXrXLJQJV+qzVHDPg7bWFm
         AGifr7QM2pjkJQW2WGi/N5wrestoiNCm+NKHih5jJlNZoIjwv3d3xdSxH7lfzo8eErFZ
         5VHQ==
Received: by 10.216.134.205 with SMTP id s55mr2499877wei.100.1330915367629;
 Sun, 04 Mar 2012 18:42:47 -0800 (PST)
Received: by 10.223.13.5 with HTTP; Sun, 4 Mar 2012 18:42:16 -0800 (PST)
In-Reply-To: <7vling6jw2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192189>

2012/3/5 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> +static int write_blob(const unsigned char *sha1)
>> +{
>> + =C2=A0 =C2=A0 unsigned char new_sha1[20];
>> +
>> + =C2=A0 =C2=A0 if (sha1_object_info(sha1, NULL) =3D=3D OBJ_TAG) {
>
> Hrm, didn't I say that it tastes bad for a function write_blob() to h=
ave
> to worry about OBJ_TAG already?

My bad. Reworked, added another test case for the dereference case,
and clone exceeded memory limit again due to new test case :( Will
need some more work on this.
--=20
Duy
