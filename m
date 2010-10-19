From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] builtins: utilize startup_info->help where possible
Date: Tue, 19 Oct 2010 13:50:15 -0500
Message-ID: <20101019185014.GG25139@burratino>
References: <1287495320-27278-1-git-send-email-pclouds@gmail.com>
 <1287495320-27278-2-git-send-email-pclouds@gmail.com>
 <20101019172953.GC25139@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 19 20:56:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8HLs-0007cP-BL
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 20:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756534Ab0JSSzz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 14:55:55 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45243 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756529Ab0JSSzy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 14:55:54 -0400
Received: by gxk21 with SMTP id 21so1057103gxk.19
        for <git@vger.kernel.org>; Tue, 19 Oct 2010 11:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=dl/X6lFNOZRo/lsIdWawpecAUYFD2+suJarxCdi7KXs=;
        b=vGRqiWojYGhJwVnqQXYC/GFMN0npGndB+qfAwE/D/ZyhBB55BpxCdh2QNNhMDWJI9q
         nnDKylQCJKRJ/KmNIe7Sx8zmEqqDZfkKrEQfxDCHO36yF8HYKDWFAjsPIsPNsjknoO/d
         +/UY3qb8JcoZZcnMZVbb821+mOyLCar8zzEc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=qVODHZZcWqB69cHLP1+GmSVMmZFAQWgvBZ+WUnU/3ZWnfgP4hqkdJAixzm79UiyRz+
         3HBgTDf2iXrjrHspha/PfS09aPaJPRX2/sTCqA0ZKH9BRl6BvLnSthziRmlE728vtkAz
         ojtlqKU2/BIApsDbv3Ha4bbBzn6hOOnF2Mhxw=
Received: by 10.103.223.19 with SMTP id a19mr5350829mur.24.1287514434324;
        Tue, 19 Oct 2010 11:53:54 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id 2sm5109763faz.14.2010.10.19.11.53.52
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 19 Oct 2010 11:53:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101019172953.GC25139@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159353>

Jonathan Nieder wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

>> It helps reduce false alarms while I'm looking for "git foo -h" code
>> path that accesses repository.
>
> Not sure I understand.  Is the idea that use of startup_info->help
> is a marker for "I've checked this code path"?
>=20
> If that were the only reason, I don't think I'd like the idea.
>=20
> As it is, I'm a bit conflicted: what if we decide to short-circuit
> "git foo --help-all" in the future just like we short-circuit
> "git foo -h" now?  Would that require a separate flag?

To be clear: I'm a bit conflicted but not extremely so.  The help
flag has the benefit of simplicity and of allowing expansion to

	git foo -h --gobbledegook

if later someone cares and a code audit shows it to be safe.
