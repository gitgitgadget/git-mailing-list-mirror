From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] i18n: avoid conflict with ngettext from libintl
Date: Wed, 9 Mar 2011 14:51:55 -0600
Message-ID: <20110309205155.GC22292@elie>
References: <4D7165A3.5080308@colin.guthr.ie>
 <7vlj0u5wyw.fsf@alter.siamese.dyndns.org>
 <4D7223A9.6080105@colin.guthr.ie>
 <7vsjuz520w.fsf@alter.siamese.dyndns.org>
 <7vhbbf50vu.fsf@alter.siamese.dyndns.org>
 <20110306225641.GB24327@elie>
 <AANLkTikctSrfqKCdeYUyvUmAZjr=i7kaFhPeB-LfwgUz@mail.gmail.com>
 <20110309103104.GA30980@elie>
 <20110309105236.GC30980@elie>
 <7vfwqw9g9b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 09 21:52:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxQMd-0003kq-VC
	for gcvg-git-2@lo.gmane.org; Wed, 09 Mar 2011 21:52:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296Ab1CIUwH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2011 15:52:07 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39059 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292Ab1CIUwE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Mar 2011 15:52:04 -0500
Received: by wwa36 with SMTP id 36so1119814wwa.1
        for <git@vger.kernel.org>; Wed, 09 Mar 2011 12:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=0MYaGa68Z2zhl4ADbLCtPRRADL2e6TRnfSCSo73pyH4=;
        b=AEj0aux/V+6BecF7iE3iTNigGQZJWY/zMDU0n7gsr2ILbwHFeQUBLEhc5VCk4aJREt
         lbq2bFNDg1ztilWSV8+7Vd5K6mb8Di9Asb/xJFfa4OZtDZ+TyttCwG4u0nJ8DzZqXrxc
         yKhNhcUg0AOt77bzcMfwtTY6YARor4G7u91Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=HV96EaJrA71v/9cBx96D7FzX858AiaOhW/P5ejfXpy2M2GRyR/7Tbw5/Wyphn1rQab
         3mGQ/GsWnkfcShw0U2wXxML1+P2OpJLQK5p+9Ui+rs2CljtAO2Bco484p3cVzkkveocP
         WjG2nd4Av0KTm2JVSBX/YFo9qmUMesVeMWz7I=
Received: by 10.227.159.204 with SMTP id k12mr6218801wbx.162.1299703922506;
        Wed, 09 Mar 2011 12:52:02 -0800 (PST)
Received: from elie (adsl-69-209-61-99.dsl.chcgil.sbcglobal.net [69.209.61.99])
        by mx.google.com with ESMTPS id o6sm1776753wbo.21.2011.03.09.12.52.00
        (version=SSLv3 cipher=OTHER);
        Wed, 09 Mar 2011 12:52:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vfwqw9g9b.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168756>

Junio C Hamano wrote:

> Hmph.  An obviously safer alternative would be to use git_ngettext() =
in
> our source all over the place, and it would by even more peace of min=
d but
> that is even longer.

Right.  That is tempting.

=C3=86var, is there some usual or obvious abbreviated form for ngettext=
 we
could use to avoid this fuss altogether?

> Also the same problem exists already for the _() macro.

The usual convention is that the _() macro is private to each
application.  libintl provides a gettext function or macro, and
various programs do

	#define _(msg) gettext(msg)

in some private header (that does not pollute the public namespace)
for notational convenience.
