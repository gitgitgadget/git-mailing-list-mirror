Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6798FC433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 09:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347293AbiCKJQu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 04:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347189AbiCKJQs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 04:16:48 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ECD1BBF59
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 01:15:46 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C5E655C0107;
        Fri, 11 Mar 2022 04:15:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 11 Mar 2022 04:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=CgZIj/poYHUIph44MvFEdPJWbk//+53kmp0OWL
        3neBs=; b=UN//fMp4Ccf86z1PsGhH9aM7I/kiQOQWULXWKozHdQKuqz/T8OXiCL
        L051JLTFQcfq7O58lTZZVJr8T8+OpP1LqwTrgQ1J5TuRgSzT/L7Ni3K5T4SRlcKd
        VUyLdY7J39+tpo5KI8uVqui9et+1oeUaJSebIBYlHZqrADFsdTzu21wQVJcmUqo7
        MZei/11AZeaLPYpbs1q16oNqaYNyTDYk3ULBlF5xbpNUs2mJcbCumVbT0dNU7Y+z
        L0B2vH5OFG8r9Q7YdItz00SwGLb4fqCN/c3o8jIs4woUr1Uz+8W3SqOdQqS1JYEn
        zstrH9yUk3WqC98j/wQlwg60O1+nH5Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=CgZIj/poYHUIph44M
        vFEdPJWbk//+53kmp0OWL3neBs=; b=ByzIkhiBC+SJUrovSOBBNXKjYMZ7g3Ews
        oYr9OAdafAIud0Uw5KbfGVbJ9gItAZpjKjsAUKDE28m7M9lVm9EAimVjPwOfvo2G
        R7yMgr+UzJ1M0qJpE+2ZxUyH+EH4An9HvXEGw8mgBvoV6y7rPnCwdB1nR5VPC8Of
        8r9pgBQARst3GRt6OiX/8o6XI7gwQNA1qFnyCqtNhP+1P9oH3Jkuul+QS5ntPyxe
        WqzmmAScKsiiReRtnz/fyLvi1TodqMslYpWPg2T9XbDgcbEx39Q8nkk3TiL0r8FI
        l1VyWNKCcUXiHd2vLLAULSCpJVAWsrZofv2xMPccWJGyCQ9OTjHhQ==
X-ME-Sender: <xms:QRMrYjD5ipdyYzFN4xTXFdWfM7nAXT33go79V5xSU_nRiGn_uTqNUQ>
    <xme:QRMrYphVQwIlhueWz9WkMQ6mPEUy6OStxhpm35d93TQbfIT5f01cwonmGIHFP7_3N
    9C6dnG83g2zfEQcxg>
X-ME-Received: <xmr:QRMrYulZEiWjugTvbqgU3q33IUc2DQEcQn2ZbmniXNKHx_VRs56EcXeEqc-cC7ADUo6tzkrZjo4pCR0kZ1BB4eHP3xZu9OGWlGDTZrR0gg3M3epAHmRJrhWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvuddguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:QRMrYlwKR3uZWNigShlCAZNZcyV6MMvl56CH5Do1g8s0kAXNxfqGMQ>
    <xmx:QRMrYoTVoeH0nBTHO8hpEWQ3-rmY3-Cd4-Pv4wAJID-6U5L4CNViDA>
    <xmx:QRMrYoYdU0Y8bQem7gY_Uv6H9uDtxm-8OJuAWs7I1UkQNfck-1h2Kg>
    <xmx:QRMrYtR1DdUaSEBiJK5Y7fpccWv4e1QUc6RWKLG-dVq-r9bJ73dsbw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Mar 2022 04:15:44 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 4f75aec7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 11 Mar 2022 09:15:42 +0000 (UTC)
Date:   Fri, 11 Mar 2022 10:15:41 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com, bagasdotme@gmail.com,
        newren@gmail.com, avarab@gmail.com, nksingh85@gmail.com,
        sandals@crustytoothpaste.net,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH 7/8] core.fsync: new option to harden loose references
Message-ID: <YisTPSOqKkQQ1RbQ@ncase>
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
 <f1e8a7bb3bf0f4c0414819cb1d5579dc08fd2a4f.1646905589.git.ps@pks.im>
 <xmqqzglx9em0.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibVaOKmKSJ9ffW8A"
Content-Disposition: inline
In-Reply-To: <xmqqzglx9em0.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ibVaOKmKSJ9ffW8A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 10, 2022 at 10:40:07PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > @@ -1504,6 +1513,7 @@ static int files_copy_or_rename_ref(struct ref_st=
ore *ref_store,
> >  	oidcpy(&lock->old_oid, &orig_oid);
> > =20
> >  	if (write_ref_to_lockfile(lock, &orig_oid, 0, &err) ||
> > +	    files_sync_loose_ref(lock, &err) ||
> >  	    commit_ref_update(refs, lock, &orig_oid, logmsg, &err)) {
> >  		error("unable to write current sha1 into %s: %s", newrefname, err.bu=
f);
> >  		strbuf_release(&err);
>=20
> Given that write_ref_to_lockfile() on the success code path does this:
>=20
> 	fd =3D get_lock_file_fd(&lock->lk);
> 	if (write_in_full(fd, oid_to_hex(oid), the_hash_algo->hexsz) < 0 ||
> 	    write_in_full(fd, &term, 1) < 0 ||
> 	    close_ref_gently(lock) < 0) {
> 		strbuf_addf(err,
> 			    "couldn't write '%s'", get_lock_file_path(&lock->lk));
> 		unlock_ref(lock);
> 		return -1;
> 	}
> 	return 0;
>=20
> the above unfortunately does not work.  By the time the new call to
> files_sync_loose_ref() is made, lock->fd is closed by the call to
> close_lock_file_gently() made in close_ref_gently(), and because of
> that, you'll get an error like this:
>=20
>     Writing objects: 100% (3/3), 279 bytes | 279.00 KiB/s, done.
>     Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
>     remote: error: could not sync loose ref 'refs/heads/client_branch':
>     Bad file descriptor    =20
>=20
> when running "make test" (the above is from t5702 but I wouldn't be
> surprised if this broke ALL ref updates).
>=20
> Just before write_ref_to_lockfile() calls close_ref_gently() would
> be a good place to make the fsync_loose_ref() call, perhaps?
>=20
>=20
> Thanks.

Yeah, that thought indeed occurred to me this night, too. I was hoping
that I could fix this before anybody noticed ;)

It's a bit unfortunate that we can't just defer this to a later place to
hopefully implement this more efficiently, but so be it. The alternative
would be to re-open all locked loose refs and then sync them to disk,
but this would likely be a lot more painful than just syncing them to
disk before closing it.

Will fix, thanks.

Patrick

--ibVaOKmKSJ9ffW8A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIrEzwACgkQVbJhu7ck
PpRHExAAgqfYLn6J2q7nBJMFaWSTBekLLvy0YGt6gC2JP6ixFQN0vdwskF9DTDzo
438Yi/dgD+D4Ef+zJgGogrLjy40dnJv2wRPHB6l7fCiAvFvLHHOcGeVKqCI4LAA3
fIEEjmSE4TKA3Pm9N5oR7CbGgVp+OK1Mbr+wfU1yRUq1qc4EPH3mKh/1RbMzb3dQ
DNQezOCdB8TFUax624X989ilvdqJ1TSEVibFpaynCrgcLNI88bY3mIVx7nVCf/7A
zNNRqkcftyyw+fNcfyHgwwxRKzjvnD1EvFFSCgjuE3ZOW5/8hhCBoAAiGYX08pt8
TgthJdHfvEVWYi9Z5B3Fh5B3Lbjo0lYJ4mk2bm8sDAjkVCdpuy1obUh7taNbGZoQ
6GHursuAgDgNv+rxRn0xT/Lql2XvQg9W0VPRettKPRKIDR3n3cCtGBOZX5CQkmJL
DqIIQTfJVmkKeiLXuvPyXxYbXNV5610gOWN5uvvFPXUsgtvCahsJIzW/mq6F0fei
kjz+65OovOkcqGm9LrY3dJnpQqBIoB1gV3THRW4SAP7N3XIBOVejm3f39GDJixfP
o+CVN/tMsgPRU5xd5IfwypZUFi7rKaGZIcCIhFkBd+R4viqjsxwihzohfa1citCA
R53/D/vqdzzrcgB7ddDf/Aghlk6Sek4V/KyCB2oYT+deqysVGP4=
=F8Cf
-----END PGP SIGNATURE-----

--ibVaOKmKSJ9ffW8A--
