From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3.5.1 04/12] send-email: Verification for --smtp-server 
	and --smpt-server-port
Date: Mon, 20 Apr 2009 10:53:11 -0500
Message-ID: <b4087cc50904200853x225acbafne421e4edb6120dbb@mail.gmail.com>
References: <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
	 <1240150785-3999-1-git-send-email-mfwitten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 17:55:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvvpb-0004Dq-9s
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 17:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114AbZDTPxO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 11:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755976AbZDTPxO
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 11:53:14 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:22117 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755768AbZDTPxN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 11:53:13 -0400
Received: by qw-out-2122.google.com with SMTP id 5so976252qwd.37
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=8m73SAtds17qkG+LfPUi7ULNpjU7YGMPqNWOVcyO5tQ=;
        b=p8kpe2LRAF1v4MkeBueMM1Bs7wLu4soLlmJ7Gb2uWp1yFyq2XQ9cl9PziORlVraG33
         DBp6VuaaO7cDNAV6t4HaJk4nXM48wB0l1bGx23pbrGC7XLGZMQbWvB5+RC559aQVs+MB
         jkHVvnPkDp2z/2UDsR4JUbILaQjXmFAwuosGI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=DDVt/O4i/3nCXhHJyi+X/rVubQm1IvYM0rik3wq6cePbYw1Te5D2Gs8g76lGsOiF+o
         i3F2vvjT+nr2h0b6nGgeT++YZ0hpUCadB7A+ChP9l55h+uySmDun7AojG1FdjStgCq2O
         dU/7KvUfk2x/dZeJAPm3LmQLfqTxIYhjyephg=
Received: by 10.224.61.14 with SMTP id r14mr6370592qah.253.1240242791237; Mon, 
	20 Apr 2009 08:53:11 -0700 (PDT)
In-Reply-To: <1240150785-3999-1-git-send-email-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117003>

On Sun, Apr 19, 2009 at 09:19, Michael Witten <mfwitten@gmail.com> wrot=
e:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ($smtp_server, my $port) =3D parse_serv=
er_URI $smtp_server
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 or die "--smtp-server: =
Not a valid server URI: '$smtp_server'\n";

Whoops! I used to have:

    my ($host, $port) =3D ...

but I tried to be clever and replaced it with the above.
Unfortunately, that means that an incorrect server 'URI' sets
$smtp_server to undef, which perl complains about when it interpolates
the die string.
