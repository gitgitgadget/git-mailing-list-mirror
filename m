From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/4] instaweb: ignore GITWEB_CONFIG_SYSTEM
Date: Fri, 3 Sep 2010 13:20:42 -0500
Message-ID: <20100903182042.GB2341@burratino>
References: <20100812131152.2333.9604.reportbug@octopus.hi.pengutronix.de>
 <20100902221211.GA4789@burratino>
 <20100902223624.GA9613@dcvr.yhbt.net>
 <20100902235237.GA6466@burratino>
 <20100902235429.GB6466@burratino>
 <7vfwxqzqoq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 20:22:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrauT-0003F4-Ur
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 20:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757189Ab0ICSWk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 14:22:40 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41904 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757095Ab0ICSWj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Sep 2010 14:22:39 -0400
Received: by wyf22 with SMTP id 22so133895wyf.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 11:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=YSq6hUl1PPR11a6yN+Wnosn2scwl4vo67ArV3GI05lU=;
        b=Kde1E4i3nIsw8W4MQD6ClZo39eb0EbB1NEq7PVJ6Q5jHCc6A7fgoRVi7o9mJSOWfgz
         ahA0x2jClbZDAv3QNXEykIJHZRmhlMLYNUo6wbywrL0dhZq2zxiQHkBdvd62z6ovUrUy
         tGpb68QpNptQ22gPLIKIha+BqQIB80hiMXNtc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=GV0ZSyQmL4nA+YF+qlGWpCYSXJaxso3K5a15vcgafkxm5MglxAyaDPhXbRZXUmDFK0
         IrGThjGPzp7xdfPK4Tmwb7iuJ9rIy0XRdNu6AwcTWya+iXQU4Z4eTX4BQdCAODr8KD4W
         OsWnzD03dJR+dCJNbElZgRTThnI7zvvA7ZetU=
Received: by 10.227.157.17 with SMTP id z17mr234540wbw.122.1283538158266;
        Fri, 03 Sep 2010 11:22:38 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id m25sm1796519wbc.19.2010.09.03.11.22.35
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Sep 2010 11:22:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vfwxqzqoq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155257>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> The configuration in /etc/gitweb.conf might specify any old
>> layout; in particular, it is likely not to be identical to that
>> which git instaweb sets up.  Noticed by Uwe Kleine-K=C3=B6nig.
>
> I am not sure if this is a reasonable change by reading the above.  I=
n
> some cases, the file may stale, but in other cases, it may specify wh=
at
> the site administrator wants its users to be using, no?

Yes, I should have mentioned this.

By analogy with .gitconfig, one might want "git instaweb" to check
GITWEB_CONFIG_LOCAL, GITWEB_CONFIG_GLOBAL, and GITWEB_CONFIG_SYSTEM in
that order, taking values from all three.  A GITWEB_CONFIG envvar
could override them all.

But stepping back a moment, what would this accomplish?  The gitweb
configuration specifies

 - what git version to use;
 - site branding;
 - what directory projects are relative to (*);
 - how deep to search for projects;
 - where the list of projects is (*);
 - how to demonstrate project consent to be shown (*);
 - whether to be a stickler about hiding secrets;
 - where gitweb.css, git-logo.png, git-favicon.png, and gitweb.js are (=
*);
 - base URI for relative paths used above (*);
 - what extra features (e.g. "snapshot") to enable;
 - MIME types, diff options, etc.

The items marked with a (*) are, in the regime used by git 1.7.1,
specific to the "git instaweb" instance, since it is all about showing
the current git repo and provides its own copies of gitweb.cgi instead
of relying on copies in /usr/share/gitweb.

The items not marked with (*) might indeed benefit from some global
site defaults.  But unfortunately, that is already not what
/etc/gitweb.conf is: it is rather used as a unit as a fallback when a
separate gitweb_config.perl is not present.

In git 1.7.2 and later, "git instaweb" provides the gitweb_config.perl
and this discussion becomes academic.

>> -s#(my|our) \$git_temp =3D.*#$1 \$git_temp =3D "'$fqgitdir/gitweb/tm=
p'";#;'
>> +s#(my|our) \$git_temp =3D.*#$1 \$git_temp =3D "'$fqgitdir/gitweb/tm=
p'";#;
>> +s#(my|our) \$GITWEB_CONFIG_SYSTEM =3D.*#$1 \$GITWEB_CONFIG_SYSTEM =3D=
 "";#;'
>
> Perhaps moving the last ' to its own line would help maintaining the
> script in the longer term?

Good idea; thanks.
