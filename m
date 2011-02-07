From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] cache-tree: do not cache empty trees
Date: Mon, 7 Feb 2011 09:36:37 +0700
Message-ID: <AANLkTinCyOq4rmb-tf4B91bK97GWca-4DyC715tUv+zx@mail.gmail.com>
References: <1296899427-1394-1-git-send-email-pclouds@gmail.com>
 <1296914835-808-1-git-send-email-pclouds@gmail.com> <7v62swwq7s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 03:37:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmGyZ-0001Uf-SS
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 03:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754433Ab1BGChJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Feb 2011 21:37:09 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64964 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754375Ab1BGChI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Feb 2011 21:37:08 -0500
Received: by wyb28 with SMTP id 28so4113581wyb.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 18:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=oxmB7zoeHK/XfkBp+LH8Qz43jvzckj7wtmOU7pKOp+0=;
        b=a+VudDkCYv/mUHttb7pxb3E3HRUlZby7q1Fwmfi/9t0jHLaN/hCfrHxLjC+r6Wue5k
         x41SoXmSWDk2HVnUV0ltlZ9lpFMOJIVqEeiYd7ziCBoW4IWNMGJdPPKGkhL1XG0xgK4l
         MXnZy3Wyu1LEB9yUnBSQKESkc61x9wPUN8ya8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TGhiSDAiPAS+g7jdoPuNvcp4uzfBRJpJlOqj+4dfouCntIBHHmlQ/ykk0jBmmEHBo6
         ijnfygFQYXnADp1S3NIK1JvnuDOKoK9Q9347fO+DUvu4VgbeTie7xiQVuE+vRR3PyVum
         YGmXyiZBzFextXIB37Gil1SYB+KC0p0y2iV+g=
Received: by 10.216.186.144 with SMTP id w16mr13655619wem.13.1297046227260;
 Sun, 06 Feb 2011 18:37:07 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Sun, 6 Feb 2011 18:36:37 -0800 (PST)
In-Reply-To: <7v62swwq7s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166224>

2011/2/7 Junio C Hamano <gitster@pobox.com>:
>> diff --git a/cache-tree.c b/cache-tree.c
>> index f755590..03732ad 100644
>> --- a/cache-tree.c
>> +++ b/cache-tree.c
>> @@ -621,9 +621,18 @@ static void prime_cache_tree_rec(struct cache_t=
ree *it, struct tree *tree)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 struct tree *subtree =3D lookup_tree(entry.sha1);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (!subtree->object.parsed)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parse_tree(subtree);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if (!hashcmp(entry.sha1, (unsigned char *)EMPTY_TREE_SHA1_BIN)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 warning("empty tree detected! Will be r=
emoved in new commits");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cnt =3D -1;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 }
>
> You shouldn't need the cast (if you did, then hashcmp() macro should =
be
> fixed so that you don't need to).

Or perhaps EMPTY_TREE_SHA1_BIN should be casted to const unsigned char
*. That would eliminate 4 typecastings elsewhere.

> I don't think warning() is warranted for an operation you introduced =
to
> keep the internal data structure consistent.

Worse. I don't think users know an empty tree is added or removed.
diff-tree does not show it (or should not, I haven't tested).

> Should this comparison done after we parsed the subtree, or should we=
 be
> doing that before it?
>
> If you are adding this new check to a point where we have already par=
sed
> the subtree object, don't you have a better and cheaper way to detect=
 if
> the subtree is empty than the 20-byte comparision, namely, perhaps by
> looking at subtree->size?

OK before is better.
--=20
Duy
