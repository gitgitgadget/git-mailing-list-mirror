From: Jonathan Nieder <jrnieder@gmail.com>
Subject: The git_remote_helpers package (Re: [RFC/PATCH 0/3] Thinning the git
 toplevel directory)
Date: Sat, 19 Feb 2011 17:15:52 -0600
Message-ID: <20110219231551.GC8884@elie>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie>
 <7vei75p3zr.fsf@alter.siamese.dyndns.org>
 <20110219111103.GA1841@elie>
 <AANLkTikK+htiiZXMBtKjuy9ZpEEoVi-BG+c5_HzLdFUP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Jeff King <peff@peff.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 00:16:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqw28-000248-BK
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 00:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874Ab1BSXP6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 18:15:58 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44231 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753395Ab1BSXP5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Feb 2011 18:15:57 -0500
Received: by iyj8 with SMTP id 8so4728444iyj.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 15:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=lA1gj2wFe8EXgMy1+cfNJyIvzS7geZ9DksVt5GrIOe8=;
        b=Uu7ic9YraQZL3XjQLnYgX9wkjo1eJ97r+qhAS6TVCC/r1cMNQaQZ6lBpaHCpSpXbwB
         Nntf93YUUiOyT5AU+cuELr0nSxoLoYiuFFwqwtMbKxT/vTU0qAGiSkoTgt4m7LppzcjC
         n/3xXnWQB46RMb0DYGKg2rjZqeu+NGrBsiP2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=EalNheRkH9r32HHiHOhi35bHmNyC468nsGZj5seleJnItwuQsr+DAq2JYC6MmtMOJ9
         8QwVprFMRZvOfrqZkjuUGmAkQhj+uOCPZEfM5lncjjc24z9PfQB7PhGMVtEmhjPqEaEX
         1ZTdSfEQRPtnEuzUjISkZTMEN0pH9cbeGfrwg=
Received: by 10.231.35.195 with SMTP id q3mr1692778ibd.186.1298157356999;
        Sat, 19 Feb 2011 15:15:56 -0800 (PST)
Received: from elie ([69.209.79.88])
        by mx.google.com with ESMTPS id z4sm3314149ibg.19.2011.02.19.15.15.54
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 15:15:55 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikK+htiiZXMBtKjuy9ZpEEoVi-BG+c5_HzLdFUP@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167385>

Sverre Rabbelier wrote:
> On Sat, Feb 19, 2011 at 12:11, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> Side note: I am not sure I like the git_remote_helpers name. =C2=A0W=
ouldn't
>> a good goal be for these modules to be usable by other VCSes'
>> import/export scripts, too?
>
> The reusable code (the fast-import library) is already living in it's
> own library on pypi, I don't think there's much other code that is
> reusable accross VCSes?

Sorry for the thinko.  I see your point.

My thinking before was that if we have packages like

 git_remote_helpers.git
 git_remote_helpers.hg

to take care of such things as cloning remote repos in preparation fro
running fast-export from them, then other VCSes (e.g., bazaar) might
want to use these packages in their foreign VCS support, too.  But
that is probably too theoretical and it is always easy to expose what
others actually need when the time comes.

Thanks,
Jonathan
