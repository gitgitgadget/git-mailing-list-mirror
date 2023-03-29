Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B76DC74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 03:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjC2Dqw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 23:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjC2Dqu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 23:46:50 -0400
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F942728
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 20:46:49 -0700 (PDT)
Received: by mail-pl1-f182.google.com with SMTP id c18so13669400ple.11
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 20:46:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680061609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ruhOI0GqSC2c70ps70AY/chEbzI+neNvhf8FHlzx/pM=;
        b=pUvgnmfnFko/epm3l7drgfNQLWmk8do6r3O25rYDQeAhkZNSDTlDIde2aeTnknYxuR
         tnx2rYTIUSUQDRcWKmowgmhPsjxFe8O3MNn82/l7It8Kzush7qx9Fi2DP3zeF3DEz/5T
         BHS9V+kPXzgRLFnZ2nAO2JkIMPJMKEKdGjrDkHZNCy65sUG3ZnD0SiGUOr2MewsSa0xX
         2tSoYD9Rzm9SDnXrdalTVtP/1s31Bv9ylpDuramNrKqQGZdQcTDDjX5MOfgjkl4dd3tK
         cFIsdPJo+UzabQTeaJeMn/tUfk0qSurneC7lKC4o9gdFnTaIhQbRZtPzQ8Hwo2CjJbC0
         7hhg==
X-Gm-Message-State: AAQBX9f3U+SzOcUkQKvZe0l0geKBwgcXVC8faL3yYtkgwm/0tOovKL1M
        z3uPoCGCIp4Jiof7V/V/hwiTD1yw3YZ/aaymqQU=
X-Google-Smtp-Source: AKy350Y2gW2aC/EhnyqFUalHjW2YFQGgub5Y0nPCM7R+gYGs7vpSNP2LfRurEIux5QS09niss9mjTj387U/6Tsj9z88=
X-Received: by 2002:a17:90a:c482:b0:240:1208:a38 with SMTP id
 j2-20020a17090ac48200b0024012080a38mr5428582pjt.9.1680061609130; Tue, 28 Mar
 2023 20:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230328202043.GA1241391@coredump.intra.peff.net>
 <20230328202819.GC1241631@coredump.intra.peff.net> <xmqqzg7wczx7.fsf@gitster.g>
 <20230329023702.GA1793752@coredump.intra.peff.net> <20230329030432.GA1801645@coredump.intra.peff.net>
 <CAPig+cQexJ9s1f6tLLaq7baeVCKhazPBi_xQ6uybkQcJQ97geg@mail.gmail.com>
In-Reply-To: <CAPig+cQexJ9s1f6tLLaq7baeVCKhazPBi_xQ6uybkQcJQ97geg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 28 Mar 2023 23:46:37 -0400
Message-ID: <CAPig+cQiOGrDSUc34jHEBp87Rx-dnXNcPcF76bu0SJoOzD+1hw@mail.gmail.com>
Subject: Re: [PATCH 3/4] tests: drop here-doc check from internal chain-linter
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>
Content-Type: multipart/mixed; boundary="0000000000006a0da605f801d355"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--0000000000006a0da605f801d355
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2023 at 11:13=E2=80=AFPM Eric Sunshine <sunshine@sunshineco=
.com> wrote:
> On Tue, Mar 28, 2023 at 11:04=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> > So I _think_ it's something like this:
> >
> > But I wasn't sure how to surface a clean error from here, since we're i=
n
> > the Lexer. Maybe we just accumulate a "problems" array here, and then
> > roll those up via the TestParser? I'm not very familiar with the
> > arrangement of that part of the script.
>
> Yes, it would look something like that and you chose the correct spot
> to detect the problem, but to get a "pretty" error message properly
> positioned in the input, we need to capture the input stream position
> of the here-doc tag itself in scan_heredoc_tag(). It doesn't look too
> difficult, and I even started writing a bit of code to do it, but I'm
> not sure how soon I can get around to finishing the implementation.

The attached patch seems to do the job. Apologies for Gmail messing up
the whitespace. It's also attached to the email.

This would probably make a good preparatory patch to your [3/4]. As
mentioned earlier in the thread, the changes to scan_heredoc_tag ()
capture the input-stream position of the here-doc tag itself, which is
necessary since it would be too late to do so by the time the error is
detected by swallow_heredocs(). I don't now when I'll get time to send
this as a proper patch, so feel free to write a commit message and
incorporate it into your series if you want to use it. And, of course,
you have my sign-off already in the patch. It should be easy to add a
test, as well, in t/chainlint, perhaps as
unclosed-here-doc.{text,expect}.

--- >8 ---
From b7103da900dd843aabb17201bc0f9ef0b7a704ba Mon Sep 17 00:00:00 2001
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 28 Mar 2023 23:35:33 -0400
Subject: [PATCH] chainlint: diagnose unclosed here-doc

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index e966412999..3dac033ace 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -80,7 +80,8 @@ sub scan_heredoc_tag {
     return "<<$indented" unless $token;
     my $tag =3D $token->[0];
     $tag =3D~ s/['"\\]//g;
-    push(@{$self->{heretags}}, $indented ? "\t$tag" : "$tag");
+    $$token[0] =3D "\t$tag" if $indented;
+    push(@{$self->{heretags}}, $token);
     return "<<$indented$tag";
 }

@@ -169,10 +170,18 @@ sub swallow_heredocs {
     my $tags =3D $self->{heretags};
     while (my $tag =3D shift @$tags) {
         my $start =3D pos($$b);
-        my $indent =3D $tag =3D~ s/^\t// ? '\\s*' : '';
-        $$b =3D~ /(?:\G|\n)$indent\Q$tag\E(?:\n|\z)/gc;
+        my $indent =3D $$tag[0] =3D~ s/^\t// ? '\\s*' : '';
+        $$b =3D~ /(?:\G|\n)$indent\Q$$tag[0]\E(?:\n|\z)/gc;
+        if (pos($$b) > $start) {
+            my $body =3D substr($$b, $start, pos($$b) - $start);
+            $self->{lineno} +=3D () =3D $body =3D~ /\n/sg;
+            next;
+        }
+        push(@{$self->{parser}->{problems}}, ['HERE', $tag]);
+        $$b =3D~ /(?:\G|\n).*\z/gc; # consume rest of input
         my $body =3D substr($$b, $start, pos($$b) - $start);
         $self->{lineno} +=3D () =3D $body =3D~ /\n/sg;
+        last;
     }
 }

--
2.40.0.460.g7fdda0a984
--- >8 ---

--0000000000006a0da605f801d355
Content-Type: application/octet-stream; 
	name="0001-chainlint-diagnose-unclosed-here-doc.patch"
Content-Disposition: attachment; 
	filename="0001-chainlint-diagnose-unclosed-here-doc.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lft519zi0>
X-Attachment-Id: f_lft519zi0

RnJvbSBiNzEwM2RhOTAwZGQ4NDNhYWJiMTcyMDFiYzBmOWVmMGI3YTcwNGJhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFcmljIFN1bnNoaW5lIDxzdW5zaGluZUBzdW5zaGluZWNvLmNv
bT4KRGF0ZTogVHVlLCAyOCBNYXIgMjAyMyAyMzozNTozMyAtMDQwMApTdWJqZWN0OiBbUEFUQ0hd
IGNoYWlubGludDogZGlhZ25vc2UgdW5jbG9zZWQgaGVyZS1kb2MKClNpZ25lZC1vZmYtYnk6IEVy
aWMgU3Vuc2hpbmUgPHN1bnNoaW5lQHN1bnNoaW5lY28uY29tPgotLS0KIHQvY2hhaW5saW50LnBs
IHwgMTUgKysrKysrKysrKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90L2NoYWlubGludC5wbCBiL3QvY2hhaW5saW50
LnBsCmluZGV4IGU5NjY0MTI5OTkuLjNkYWMwMzNhY2UgMTAwNzU1Ci0tLSBhL3QvY2hhaW5saW50
LnBsCisrKyBiL3QvY2hhaW5saW50LnBsCkBAIC04MCw3ICs4MCw4IEBAIHN1YiBzY2FuX2hlcmVk
b2NfdGFnIHsKIAlyZXR1cm4gIjw8JGluZGVudGVkIiB1bmxlc3MgJHRva2VuOwogCW15ICR0YWcg
PSAkdG9rZW4tPlswXTsKIAkkdGFnID1+IHMvWyciXFxdLy9nOwotCXB1c2goQHskc2VsZi0+e2hl
cmV0YWdzfX0sICRpbmRlbnRlZCA/ICJcdCR0YWciIDogIiR0YWciKTsKKwkkJHRva2VuWzBdID0g
Ilx0JHRhZyIgaWYgJGluZGVudGVkOworCXB1c2goQHskc2VsZi0+e2hlcmV0YWdzfX0sICR0b2tl
bik7CiAJcmV0dXJuICI8PCRpbmRlbnRlZCR0YWciOwogfQogCkBAIC0xNjksMTAgKzE3MCwxOCBA
QCBzdWIgc3dhbGxvd19oZXJlZG9jcyB7CiAJbXkgJHRhZ3MgPSAkc2VsZi0+e2hlcmV0YWdzfTsK
IAl3aGlsZSAobXkgJHRhZyA9IHNoaWZ0IEAkdGFncykgewogCQlteSAkc3RhcnQgPSBwb3MoJCRi
KTsKLQkJbXkgJGluZGVudCA9ICR0YWcgPX4gcy9eXHQvLyA/ICdcXHMqJyA6ICcnOwotCQkkJGIg
PX4gLyg/OlxHfFxuKSRpbmRlbnRcUSR0YWdcRSg/OlxufFx6KS9nYzsKKwkJbXkgJGluZGVudCA9
ICQkdGFnWzBdID1+IHMvXlx0Ly8gPyAnXFxzKicgOiAnJzsKKwkJJCRiID1+IC8oPzpcR3xcbikk
aW5kZW50XFEkJHRhZ1swXVxFKD86XG58XHopL2djOworCQlpZiAocG9zKCQkYikgPiAkc3RhcnQp
IHsKKwkJCW15ICRib2R5ID0gc3Vic3RyKCQkYiwgJHN0YXJ0LCBwb3MoJCRiKSAtICRzdGFydCk7
CisJCQkkc2VsZi0+e2xpbmVub30gKz0gKCkgPSAkYm9keSA9fiAvXG4vc2c7CisJCQluZXh0Owor
CQl9CisJCXB1c2goQHskc2VsZi0+e3BhcnNlcn0tPntwcm9ibGVtc319LCBbJ0hFUkUnLCAkdGFn
XSk7CisJCSQkYiA9fiAvKD86XEd8XG4pLipcei9nYzsgIyBjb25zdW1lIHJlc3Qgb2YgaW5wdXQK
IAkJbXkgJGJvZHkgPSBzdWJzdHIoJCRiLCAkc3RhcnQsIHBvcygkJGIpIC0gJHN0YXJ0KTsKIAkJ
JHNlbGYtPntsaW5lbm99ICs9ICgpID0gJGJvZHkgPX4gL1xuL3NnOworCQlsYXN0OwogCX0KIH0K
IAotLSAKMi40MC4wLjQ2MC5nN2ZkZGEwYTk4NAoK
--0000000000006a0da605f801d355--
