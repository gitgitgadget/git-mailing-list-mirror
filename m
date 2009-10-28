From: Vietor Liu <vietor@vxwo.org>
Subject: Re: [PATCH] imap-send.c: fix pointer to be const
Date: Wed, 28 Oct 2009 15:05:26 +0800
Message-ID: <1256713526.3333.0.camel@localhost.localdomain>
References: <1256706591-2763-1-git-send-email-vietor@vxwo.org>
	 <7vk4ygxce6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:10:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N32gF-0005iF-Ep
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 08:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757483AbZJ1HKl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Oct 2009 03:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757477AbZJ1HKl
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 03:10:41 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:41404 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757473AbZJ1HKk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 03:10:40 -0400
Received: by yxe17 with SMTP id 17so420798yxe.33
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 00:10:45 -0700 (PDT)
Received: by 10.90.128.9 with SMTP id a9mr1402095agd.117.1256713480680;
        Wed, 28 Oct 2009 00:04:40 -0700 (PDT)
Received: from ?192.168.254.103? ([123.113.74.202])
        by mx.google.com with ESMTPS id 35sm333014yxh.15.2009.10.28.00.04.37
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 00:04:39 -0700 (PDT)
In-Reply-To: <7vk4ygxce6.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.0 (2.28.0-2.fc12) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131411>

On Tue, 2009-10-27 at 23:26 -0700, Junio C Hamano wrote:
> Vietor Liu <vietor@vxwo.org> writes:
>=20
> > Fixes some compiler warnings:
> > imap-send.c: In function =E2=80=98ssl_socket_connect=E2=80=99:
> > warning: assignment discards qualifiers from pointer target type
> >
> > Signed-off-by: Vietor Liu <vietor@vxwo.org>
>=20
> I do not quite understand.  This variable gets assigned the return va=
lues
> from TLSv1_method() or SSLv23_method(), but the copy of ssl.h I have
> declares them as:
>=20
>     SSL_METHOD *SSLv23_method(void);	/* SSLv3 but can rollback to v2 =
*/
>     SSL_METHOD *TLSv1_method(void);		/* TLSv1.0 */

1. openssl-devel-1.0.0-0.10

const SSL_METHOD *SSLv23_method(void);	/* SSLv3 but can rollback to v2
*/
const SSL_METHOD *TLSv1_method(void);		/* TLSv1.0 */


2. http://www.openssl.org/docs/ssl/ssl.html

const SSL_METHOD *SSLv2_method(void);
       =20
        Constructor for the SSLv2 SSL_METHOD structure for combined
        client and server.
const SSL_METHOD *TLSv1_method(void);
       =20
        Constructor for the TLSv1 SSL_METHOD structure for combined
        client and server.

3. it maybe fixes warnings for other version.
