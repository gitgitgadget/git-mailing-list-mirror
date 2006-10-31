X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 4/n] gitweb: Secure against commit-ish/tree-ish with the same name as path
Date: Tue, 31 Oct 2006 17:53:20 +0100
Message-ID: <200610311753.20711.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com> <200610302229.06957.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 31 Oct 2006 16:53:51 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hQl/ScBPRgb3vhAfo9RSjDbNWxC9nRT7+iiCkbpRdc0A6ugx0XsRInnc2W6Y0uwiQq+0gssziDxQUH1r6dwOyZAVNZMHk9czDs3eZwiu303Fnr1loW1QWjc4e8tKlCjSQwnR81DehfF/vIkI/Spq71VDqcm5B8cuA0FGxnOI+cU=
User-Agent: KMail/1.9.3
In-Reply-To: <200610302229.06957.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30592>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GewrZ-0005mv-SB for gcvg-git@gmane.org; Tue, 31 Oct
 2006 17:53:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423555AbWJaQxR convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006 11:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423565AbWJaQxR
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 11:53:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:42886 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1423555AbWJaQxQ
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 11:53:16 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1499470ugm for
 <git@vger.kernel.org>; Tue, 31 Oct 2006 08:53:15 -0800 (PST)
Received: by 10.67.101.10 with SMTP id d10mr6408150ugm; Tue, 31 Oct 2006
 08:53:15 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id m1sm5264145uge.2006.10.31.08.53.14; Tue, 31 Oct
 2006 08:53:15 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Jakub Narebski wrote:
> @@ -2970,7 +2972,7 @@ sub git_tree {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> =A0=A0=A0=A0=A0=A0=A0=A0}
> =A0=A0=A0=A0=A0=A0=A0=A0$/ =3D "\0";
> -=A0=A0=A0=A0=A0=A0=A0open my $fd, "-|", git_cmd(), "ls-tree", '-z', =
$hash
> +=A0=A0=A0=A0=A0=A0=A0open my $fd, "-|", git_cmd(), "ls-tree", '-z', =
$hash, "--"
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0or die_error(undef, "=
Open git-ls-tree failed");
> =A0=A0=A0=A0=A0=A0=A0=A0my @entries =3D map { chomp; $_ } <$fd>;
> =A0=A0=A0=A0=A0=A0=A0=A0close $fd or die_error(undef, "Reading tree f=
ailed");

Please remove this chunk from patch!. It makes gitweb "tree" view
empty. I have forgot that git-ls-tree _requires_ <tree-ish> so there
is no way to mistake pathspec with <tree-ish>.

Bit overeager adding of "--"...=20
--=20
Jakub Narebski
