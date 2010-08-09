From: Jonathan Nieder <jrnieder@gmail.com>
Subject: discarding refs/original/* after filter-branch (Re: understanding
 how remote tracking works)
Date: Mon, 9 Aug 2010 18:07:11 -0500
Message-ID: <20100809230711.GH4429@burratino>
References: <AANLkTi=J3tDnZUg3k5bzDk2ydzYVVLKLwoW0gpBypYAs@mail.gmail.com>
 <i3nlq0$8un$1@dough.gmane.org>
 <AANLkTinktpx-rXj1K0BSy0Qwo62SEGFAJWvhKo0nJq=i@mail.gmail.com>
 <AANLkTi=usaZGfOM67acmdAWwvbHe_eHyjmRLGmdTYNaC@mail.gmail.com>
 <20100809021900.GA10596@burratino>
 <7vaaov60rv.fsf@alter.siamese.dyndns.org>
 <20100809205309.GA3204@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>, geoffrey.russell@gmail.com,
	Ralf Ebert <info@ralfebert.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 01:08:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OibSZ-00081Z-5Q
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 01:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757219Ab0HIXIj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 19:08:39 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58295 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757012Ab0HIXIi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 19:08:38 -0400
Received: by vws3 with SMTP id 3so7143374vws.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 16:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=c0doMMOM7PtgLM5CDmAdkFXjZK1Kqq6744/bb+g4zFU=;
        b=obl27OMvURcNztSC6G0rAtZEmOGhgAsBjTs+zfXySYNF6/LePKtjBL34/B+cyjanpp
         2jVxATWPFfuogsGW/t4UW72kYNlkOzDvHCamR+K2Bk1+Gsr5wHxYH4aIMMylUfdA/HmC
         LOY1KowO1yc7wtVytCPQOm9tK2/31gZrCQnK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=vu5hOy1HE0gPkjdJ9OaxGMzN8Epha/+3RzODLxvafPHVnRin+LdeyFpNJWsprUNSwp
         yPu/CwoO2xfN6Pqgrb5FQ0Z6zxZRd8Rwd4UxwpVjUiA2MzjDUMFgEmZIxFurGWbBhnAj
         6BTANuGse5tZz5AzOgKCIQu0M0yYARoSoFG5s=
Received: by 10.220.60.204 with SMTP id q12mr9930549vch.43.1281395317846;
        Mon, 09 Aug 2010 16:08:37 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id w6sm362536vcj.27.2010.08.09.16.08.36
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 16:08:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100809205309.GA3204@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153051>

Jonathan Nieder wrote:

> There are a lot of instances of =E2=80=9Crm -r .git/refs/original=E2=80=
=9D after
> running filter-branch, too.  Maybe filter-branch ought to provide
> some synonym for
>=20
>  eval "$(
> 	git for-each-ref refs/heads/\* --shell --format=3D'git update-ref -d=
 %(refname) &&' &&
> 	echo :
>  )"

That should have read as

 ...
	git for-each-ref refs/original --shell ...

Sorry about that.
