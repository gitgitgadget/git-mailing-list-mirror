Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7773C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 20:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFBE661421
	for <git@archiver.kernel.org>; Thu, 13 May 2021 20:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbhEMUar (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 16:30:47 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:36419 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232916AbhEMUae (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 13 May 2021 16:30:34 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 78C742207;
        Thu, 13 May 2021 16:29:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 13 May 2021 16:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        linuxprogrammer.org; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:content-transfer-encoding
        :in-reply-to; s=fm3; bh=D90AOEKkqLTnLJRB9dqStZB12AqOnFuR/jGAKokH
        IY8=; b=jqzFraJMX/SSWF8IUUypT3asphpI1Qit68IVRF89Jw08phZVpQ4YKEbv
        9xhwEz19qzuQ5p6MMDHdDAD8kqa85ltJd3l4ApkW3djHhmXba4GbtrFVBD1+F5Wi
        3n6u0ugeIDqvkjjc03BycFZSAt32ysvjBUVfb8IkmKHXPEZhq88MKxmLbTirdfR/
        3O0OxuW0th/HR0F24jD10jpeymFsMsb1/eFxSrem99AsOjwczzTSHIkJHTq/4Z2u
        R0IkG3TFiB5lkY8vwsTeNegBVuyStf1W1AO8g3vepYvgBUgxkwH2nxM6Qm4ZvsnT
        zT5LO/KDiX3lQYqSywLNo9ARD1di9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=D90AOEKkqLTnLJRB9dqStZB12AqOnFuR/jGAKokHI
        Y8=; b=Pj1ecrrWxNlwurZER4LG0W5wjxAQ96nij6jyMrX7ImOYWQ7hOLXAPpn33
        dwy3RktaLKm6aMeqzHOi1Qg+++nINuQ8pSDtM+HoYybx0KBAG+62Eb0tKRhjYjIO
        A6KdIfbuwCpzlAGwDnRYven59eVCi15s6lpHRixIlyiR3fWPjwhjOSge1iSmfsin
        mIjFLr9N65KK1vsR7W+blGn57vS+x2aG97DUJ+Zl02JYSOh0couktwIQYFyLAiGG
        uR4CXLrbNzjAYHBhHbTbAWnngxFylSFTaP1pK1Uuovy6Y/A88TAWSXeAQnZD2Sla
        EopDanThOoVnW5a40BYK8S2sthGqQ==
X-ME-Sender: <xms:IYydYJSewh01yVVCEFzdETJodYSExZN0Catq2sSxOuqyJ5uLiPCAdQ>
    <xme:IYydYCyZvFY1rDq0_EZRGcBr4Yo1xuzrH2tr4mQsPLLbNcppUCru-cn9Mnr70HRl-
    CLY0WXk_7NKNzqp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehgedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtugfgjggfse
    htkeertddtreejnecuhfhrohhmpegufihhsehlihhnuhigphhrohhgrhgrmhhmvghrrdho
    rhhgnecuggftrfgrthhtvghrnhepjefgjedvfeffteetvefhlefhkeeufefhvdekgfevtd
    ejueegkeekfeevhefhheelnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpihguvghn
    thhithihrdhfohhunhgurghtihhonhdpkhgvrhhnvghlrdhorhhgnecukfhppedujeegrd
    ehvddrudehrdefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpegufihhsehlihhnuhigphhrohhgrhgrmhhmvghrrdhorhhg
X-ME-Proxy: <xmx:IYydYO0X27MNzWLIQkZw0UCMsjHh1HFnXj5YlBjN3wy3-V4HKUSAQA>
    <xmx:IYydYBCKJ0Xw_84XDV4_IIEi5GKXKxydXW-5-NTU7V2TgSqUX6N7bQ>
    <xmx:IYydYCjt41qBPWihI6zVM8zOkXXci8fFOYGkrZsbvD1G3Aa0Th4Gjw>
    <xmx:IoydYIdFkjg4QvHdi263vkigrP6mkQix9pdb7Jks9nVwtp0wsiQAgg>
Received: from localhost (c-174-52-15-37.hsd1.ut.comcast.net [174.52.15.37])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Thu, 13 May 2021 16:29:21 -0400 (EDT)
Date:   Thu, 13 May 2021 13:29:19 -0700
From:   dwh@linuxprogrammer.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: Is the sha256 object format experimental or not?
Message-ID: <20210513202919.GE11882@localhost>
References: <20210508022225.GH3986@localhost>
 <YJcqqYsOerijsxRQ@camp.crustytoothpaste.net>
 <87lf8mu642.fsf@evledraar.gmail.com>
 <YJm23HESQb1Z6h8y@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YJm23HESQb1Z6h8y@camp.crustytoothpaste.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10.05.2021 22:42, brian m. carlson wrote:
>Almost nobody is using it because the main forges don't yet support it,
>because it's going to be just as much work to support it there as it has
>been in Git.  We won't be making it easier by making deliberately
>incompatible changes when we don't have to.

I know that you said there is no reason to make a breaking change to the
SHA256 implementation now, but because of what you say above, I think we
still have the opportunity to make breaking changes. In any case I think
we only need to make one breaking change to gain algorithmic agility
going forward and avoid painful, multi-year transitions like the one
you've been executing.

My project to add universal cryptographic signing to Git by using a
standard protocol and generalized configuration to support any
cryptographic signing scheme could also apply to the digests as well,
and I think it should. If object digests in Git were self-describing
(i.e. they contain an algorithm identifier as well as the digest) then
repos gain "algorithmic agility" and can change algorithms at any time
to keep up as algorithms grow stale and are replaced.

I think Git should externalize the calculation of object digests just
like it externalizes the calcualtion of object digital signatures.
Cryptography is very difficult to get correct and the dedicated tools
for that (e.g. OpenSSH, OpenSSL, GnuPG, etc) get lots of scrutiny and
have the best chance of getting it right. I don't think Git should try
to do cryptography at all.

Object digests should just be names for objects; Git doesn't really need to
know anything more than "is this the name for that object?". Answering
that question can, and should, be done by an external tool that is
implemented correctly and hardened against attack. I think the only
counter-argument for this approach is performace related. Pipe-forking a
child process and reading/writing over IPC pipes is expensive in terms
of context switching and process setup/teardown but there are a number
of mitigations I won't go into here.

I think we should make one last breaking change for digests and not go
with the existing SHA-256 implementation but instead switch to
self-describing digests and digital signatures and rely on external
tools that Git talks to using a standard protocol. We can maintain full
backward compatibility and even support full round tripping using some
of the similar techniques that Brian came up with. A transitional
half-old/half-new signed tag could look like:

```
object 04b871796dc0420f8e7561a895b52484b701d51a
obj 0ED_zgYrQg584bCrqKPoUvxaQ5aMis0GtnW_NrZFTTxUlHLUOyp77LanoZEGV6ajhYGLGTaTfCIQhryovyeNFJuG
type commit
tag signedtag
tagger C O Mitter <committer@example.com> 1465981006 +0000
signtype openpgp
sign LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlRRWN
 CQUFCQWdBR0JRSlhZUmhPQUFvSkVHRUpMb1czSW5HSmtsa0lBSWNuaEw3UndFYi8rUWVYOWVua1
 hoeG4KcnhmZHFydldkMUs4MHNsMlRPdDhCZy9OWXdyVUJ3L1JXSitzZy9oaEhwNFd0dkUxSERHS
 GxrRXozeTExTGt1aAo4dFN4UzNxS1R4WFVHb3p5UEd1RTkwc0pmRXhoWmxXNGtuSVExd3QveVdx
 TSszM0U5cE40aHpQcUx3eXJkb2RzCnE4RldFcVBQVWJTSlhvTWJSUHcwNFM1anJMdFpTc1VXYlJ
 Zam1KQ0h6bGhTZkZXVzRlRmQzN3VxdUlhTFVCUzAKcmtDM0pyeDc0MjBqa0lwZ0ZjVEkyczYwdW
 hTUUx6Z2NDd2RBMnVrU1lJUm5qZy96RGtqOCszaC9HYVJPSjcyeApsWnlJNkhXaXhLSmtXdzhsR
 TlhQU9EOVRtVFc5c0ZKd2NWQXptQXVGWDJrVXJlRFVLTVpkdUdjb1JZR3BEN0U9Cj1qcFhhCi0t
 LS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo

signed tag

signed tag message body
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAABAgAGBQJXYRhOAAoJEGEJLoW3InGJklkIAIcnhL7RwEb/+QeX9enkXhxn
rxfdqrvWd1K80sl2TOt8Bg/NYwrUBw/RWJ+sg/hhHp4WtvE1HDGHlkEz3y11Lkuh
8tSxS3qKTxXUGozyPGuE90sJfExhZlW4knIQ1wt/yWqM+33E9pN4hzPqLwyrdods
q8FWEqPPUbSJXoMbRPw04S5jrLtZSsUWbRYjmJCHzlhSfFWW4eFd37uquIaLUBS0
rkC3Jrx7420jkIpgFcTI2s60uhSQLzgcCwdA2ukSYIRnjg/zDkj8+3h/GaROJ72x
lZyI6HWixKJkWw8lE9aAOD9TmTW9sFJwcVAzmAuFX2kUreDUKMZduGcoRYGpD7E=
=jpXa
-----END PGP SIGNATURE-----
```

I think a good move to make right now would be to add a general function
for stripping out any number of named fields from objects and also
stripping out in-body signatures found in tags. That way we can add
support in today's Git for stripping out fields/data for things like
creating/verifying the object digest and/or digital signature.

BTW, in the example above the 'obj' field is a self-describing, URL-safe
Base64 encoded Blake2b-512 digest encoded using the format described
[here][1]. The starting '0E' Base64 characters identify the digest as
Blake2b-512 and also specify that the length of the digest is 64-bytes.
If you Base64 decode the 'obj' field value you get 66 bytes, the digest
value is the last 64 bytes of the 66 bytes.

By going with self-describing digests we can have configuration files
that contain 'program' and 'options.*' for each external tool that can
create/validate digests of each type. So in this case there would be
something like:

```
[digest "blake2b"]
  program = "blake2bsum"
[digest "blake2b.options"]
  length = 64
```

Using self-describing cryptographic constructs for digests and
signatures and relying on external tools makes it trivial for Git to
walk the object graph and enumerate all of the digest types and
signature types in a given repo and determine if a user has their
configuration set up correctly to work with that repo. Projects can
declare which types they are using and recommend tools to use for those
types.

Cheers!
Dave

TL;DR

Let me try to lay out the case for making a breaking change to sha256
right now that will future-proof repos going forward.

It has been known for a few decades now that cryptography has a
shelf-life. By that I mean as technology and cryptanalisys improves we
have had to make keys larger and invent new algorithms that resist the
new attacks on cryptography. This has been true digest algorithms (i.e.
hashes), digital signatures (i.e. non-repudiation), and encryption (i.e.
confidentiality). The relevant case here is the fact that sha256 is
vulnerable to extension attacks and cryptographers have lost some
confidence in it after many Davies-Meyer (DM) structure and ARX network
designs based on MD4 were broken 20 years ago. SHA-256 uses DM plus a
block cipher based on an ARX network. The end result is that in high
security software, SHA-256 is being replaced with SHA-3 and Blake2
digests.

Another key thing to think about is that a git repo is a form of a
provenance log that could become the primary tool for securing the
software supply chain if we were to make some careful, well thought out
changes arond the digests and digital signatures. What changes exactly?

1. upgrade the digests to something cryptographically secure.
2. digitally sign all commits/merges/tags using...
3. key material tracked with cryptographically secure provenance logs
inside of the repo itself.
4. switch to "late binding", "self describing" cryptographic constructs.

Let me go over these and describe how these fit together.

1. SHA-1 is not cryptographically secure and SHA-256 is already not
   being used in *new* systems and is being replaced in existing, high
   security systems. I think Git should move to more secure digest
   algorithms because the hashes in Git repos are used as naming
   identifiers for Git objects which gives them a higher security
   burden.

2. Digitally signing all commits/merges/tags is critical to tie
   contributions to contributors in a non-repudiable fashion. At the
   very least it is a more secure solution for S-o-b but it also opens
   up the possibility for cryptographically secure accountability. Banks
   and governments are already doing know-your-customer (KYC)
   verifications of identity that can be used to identify contributors
   and their contributions cryptographically. If privacy is a concern,
   zero-knowledge proofs, based on the KYC authentic data, can be used
   to create pseudonymous identities for contributors that can be linked
   to their real-world identity under judicial order. Essentially a
   developer can say, "you don't need to know my real world identity but
   here's proof that XYZ bank knows who I am and here is a large random
   number you can use to de-anonymize me with the help of a court if
   needed"

3. The key material used for identifying contributors needs to move into
   the repos themselves for many reasons but the most important two
   reasons are (1) the repo comes with all of the data necessary to
   verify all of the digital signatures (i.e. solving the PKI problem
   for a project) and (2) to track the provenance of the public keys and
   other related data that each contributor uses. If Git repos contain
   provenance logs that are controlled and maintained by each
   contributor, those logs can also contain digital signatures over the
   code of conduct and the developer certificate of origin and other
   governing documents for a project that are legally binding (i.e.
   follow eIDAS and other legal digital signature rules). Solving the
   PKI problem alone makes digitally signing commits infinitely more
   useful and will drive adoption. Solving the non-repudiable provenance
   problem is the raison d'être of organizations like the Linux
   Foundation. I think Git should align itself with where technology is
   heading on that front.

4. Currently Git uses "early-binding" for all cryptographic material.
   The digest algorithm is hard coded (SHA-1) and the new SHA-256 is as
   well. The digital signature algorithm is also hard coded as either
   GPG or GPGSM. Early-binding makes it very difficult to plan for the
   obsolescense of cryptographic algorithms. The solution is to move to
   "late-binding"/"self-describing" cryptographic constructs. If Git
   were to switch to self-describing digests and digital signatures,
   then Git could be entirely agnostic to cryptography and rely entirely
   upon external crytpographic tools for creating/verifying digests and
   digital signatures. Instead of the direction we're taking on the
   SHA256 changeover, I think Git should switch to self-describing
   digests and digital signatures and use a standard protocol for
   talking to external cryptographic tools instead of trying to get
   cryptography correct in its code.

   Secure Scuttlebutt uses late-binding constructs that contain a type
   "sigil", Base-64 encoded key/digest/blob followed by an algorithm
   decriptor (e.g. ".sha256" or ".ed25519"). Other examples exist such
   as the Multihash encoding scheme for self-describing hashes. All of
   my work on secure provenance logs uses the emerging consensus
   encoding described [here][1]. It uses Base64 encoded cryptographic
   data and it fills what would be the padding bytes with type
   identifiers. I'm not the only one thinking along these lines. The
   [KERI project][2] at the Decentralized Identity Foundation as well as
   [Konstantin][3].


[1]: https://github.com/decentralized-identity/keri/blob/master/kids/kid0001.md
[2]: https://identity.foundation/working-groups/keri.html
[3]: https://people.kernel.org/monsieuricon/patches-carved-into-developer-sigchains
