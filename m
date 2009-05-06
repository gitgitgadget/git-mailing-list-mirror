From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: shell compatibility issues with SunOS 5.10
Date: Wed, 6 May 2009 16:57:16 +1000
Message-ID: <fcaeb9bf0905052357v6773cbf5i12795c1866a80783@mail.gmail.com>
References: <20090506055913.GA9701@dektop> <4A01320A.2050600@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 06 08:58:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1b4u-0001nj-74
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 08:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961AbZEFG5i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2009 02:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752376AbZEFG5h
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 02:57:37 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:59785 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbZEFG5g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2009 02:57:36 -0400
Received: by an-out-0708.google.com with SMTP id d40so8338442and.1
        for <git@vger.kernel.org>; Tue, 05 May 2009 23:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=d9LNfYIKKMazouPbHkCUh35sv/EbtdRWPZTtN+OJByE=;
        b=lOKl3rYty6JEYEZq1d76jpo0jivruVpZQvZfXuMJeI63v1VUqhCrkO/Ok6FrrTews2
         XF/Aw4V2gl4lTFkTSWpRLGIkomQktNU6+dGwQH3XZHnIW8GTVnZj+PFTggWLM6XGg/+2
         F07L7ajH3oEIPpjcGUCdocHqpt9R8FfI+cZqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=AFPhB5lhyuT+WFRFv374RPhUjg8Qbr3I6mtRKoKEZlUwtqL+mfkE6z50NB+ohEOQbf
         OekouCHbpzLGB2OKBACEr2CpQ/8IXKVZ2H6ldQuLcDyGlFBthvq5gxOfLbQtSgXFapwB
         KeEmQ5AGCLkDcx+IA60os+W8dp89QMeIqVO6I=
Received: by 10.100.96.9 with SMTP id t9mr2032128anb.106.1241593056398; Tue, 
	05 May 2009 23:57:36 -0700 (PDT)
In-Reply-To: <4A01320A.2050600@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118328>

On Wed, May 6, 2009 at 4:45 PM, Johannes Sixt <j.sixt@viscovery.net> wr=
ote:
> Nguyen Thai Ngoc Duy schrieb:
>> I did "make test" on a SunOS 5.10 and it failed. With the below patc=
h,
>> only t7400 and t8005 kept failing. For the first case, t7400.5 faile=
d
>> because extensive use of sed to normalize path in git-submodule.sh
>>
>> =C2=A0 =C2=A0 =C2=A0 # normalize path:
>> =C2=A0 =C2=A0 =C2=A0 # multiple //; leading ./; /./; /../; trailing =
/
>> =C2=A0 =C2=A0 =C2=A0 path=3D$(printf '%s/\n' "$path" |
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sed -e '
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 s|//*|/|g
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 s|^\(\./\)*||
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 s|/\./|/|g
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 :start
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 s|\([^/]*\)/\.\./||
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 tstart
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 s|/*$||
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ')
>
> There was a lengthy thread that lead to this version of the sed
> expression. Could you please tell what your sed has to say about it? =
It
> works even on AIX 4.3.3.

It says nothing. The result of "printf '%s\n' ./foo/bar | sed -e blah"
is just wrong, (i.e. "./" remains). I stripped down to "sed -e
's|^\(\./\)*||'", does not work. Probably due to \( \) pair. Skimmed
through sed manpage, seems no mention of bracket grouping.
--=20
Duy
