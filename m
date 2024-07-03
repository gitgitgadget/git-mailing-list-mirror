Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5460D1607A3
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 15:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720020310; cv=none; b=QuEusT5uY9wdOd02acYn97OCoNXWqrs0wRzO3h+p3jmvdrGEHIgAOX6LCF+O5FtvFOsPTaq3IgyEWs0zpkgwMMD8i9lcPoeliMjXC9FeHu+wnba0zO6amTI0GuLxO4EK/BizIZXfqHLcZX5jRciD0QTwGUX6hGfU72D4RqjqfNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720020310; c=relaxed/simple;
	bh=2Sisl5ftFueA02spYNw1OWpOG1ruXq9QDEQV+LgMH2s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=I8W3bq4RfhrPgeT7zxjMBQUpxVVE+vqyrEAyRaUjke71T7V8kC3RRTJepUewmD3PQPFIN+QLhrm8gy2GW95Vcd0GYJ5ibjCpW5i+NNjarQpFBH0maL+PAmjqu58LN/BRcRiQB+1aALLfTEIeOBEqHVU4OSyIsftkFFEREcvUoQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rjln+Qbn; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rjln+Qbn"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e026a2238d8so5456626276.0
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720020308; x=1720625108; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jnhHufBKAN+eR8rSz0S2BbGvK5aM5W4sT8eljX4P5vY=;
        b=Rjln+QbnCV0eMjuLjSI1U630kjKOZDPabDcsQuZYwYyrKVua4atvcCTDHCJNkAE1vn
         rgQAsH7qBpTpyHf2Fkj3QPudM5rGt/X2cP8vpJOdBhVn9hb57zw86PcVtkgk+4GpoGd1
         rSWJkevrEx610gaJjL70lPpiFwDRG9LfFMGtXFF/2Av3iXrf/MD975posWf/aYyt1CkC
         ynyZuPI0udqaKDGuobLb2v4OuWYpfKS8UeUGfbMLxE3A+SZxwn2YvjZn2/i+J8ocHDmf
         vP3Xkah8DnCqPoF8ppUb140L/Ae2JtyQjnor6P7C5tLuMNftcpG1AJR8gzq1SKkOMDo6
         c3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720020308; x=1720625108;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jnhHufBKAN+eR8rSz0S2BbGvK5aM5W4sT8eljX4P5vY=;
        b=POl6zjendX97ZyAkyk9xNh5/65P7JbvFgdNLGwZHMlvERRRVrAbTMIRuTQ+tBdHVlv
         xOucBReU9YnERv7aPyYvvQmHsbFMAJJtusPcCNy4QDHQ+dxTtgOvPiWQf0SkAEm4VZVj
         IqDJOgmAfKDyXZKJUiwithWTttA1/KStJlgU0oPWvH0w18Bgq91KOp1QlvQJI6+Plm3q
         BqSQjAwJ5Qs/NnQ5NYO5lY5WU2cDfTBgWBGWkPsgHKNCoGgZygB1wIJHk+BdMMLkl7cJ
         RVT1dMd3aJ6UHjJDvQXo5YiHfloktTcyJTs7J0B5MsAqBRX6lR/m5d8ytMzrwdYhq4xw
         K0VA==
X-Gm-Message-State: AOJu0YxcZ28FuJEhR/24Bi8nbgEd+D4ciIKnXIaETroDcfs9RcgxxGtl
	IL4Ihw4gK8gW2b9I12qxMOtkV6VTuk+NTC7jioFQrNqusQPq3d3GUTV8RwshCpK8HB8tuucgGsL
	XfWEGE30uNHBCGkbD56v1WIN+3I+H0Q==
X-Google-Smtp-Source: AGHT+IE/avjz31E8K9mDaQiwiRre2pY6gpWY2gBDTZ+3YNYy/DSY9S1mwrYqkFLD42Zcc9VmGgqp7fxg4dIv4RxQBGU=
X-Received: by 2002:a05:6902:566:b0:e03:513e:120a with SMTP id
 3f1490d57ef6-e036eb21152mr13949170276.12.1720020308195; Wed, 03 Jul 2024
 08:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Emanuel Czirai <correabuscar+gitML@gmail.com>
Date: Wed, 3 Jul 2024 17:24:58 +0200
Message-ID: <CAFjaU5sAVaNHZ0amPXJcbSvsnaijo+3X5Otg_Mntkx2GbikZMA@mail.gmail.com>
Subject: `git diff`/`git apply` can generate/apply ambiguous hunks (ie. in the
 wrong place) (just like gnu diff/patch)
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This doesn't affect `git rebase` as it's way more robust than simply
extracting the commits as patches and re-applying them. (I haven't looked
into `git merge` though, but I doubt it's affected)

It seems to me that no matter which algorithm `git diff` uses  (of the 4),
it generates the same hunk, because it's really the context length that
matters (which by default is 3), which is the same one that gnu `diff`
generates, and its application via `git apply` is the same as gnu `patch`.

side note:
`diffy` is a simple rust-written library that behaves (at version 0.4.0)
the same as normal diff and patch apply(with regards to generated diff
contents and patch application; except it doesn't set the original/modified
filenames in the patch), and since my limited experience, I've found it
simpler to modify it to make it so that it generates unambiguous hunks, as
a proof of concept that it can be done this way, here:
https://github.com/bmwill/diffy/issues/31 , whereby increasing the context
length(lines) of the whole patch(though ideally only of the affected hunks)
the initially ambiguous hunk(s) cannot be applied anymore in more than 1
place inside the original file, thus avoiding both the diff creation and
the patch application from generating and applying ambiguous hunks.

But forgetting about that for a moment, I'm gonna show you about `git diff`
and `git apply` below:
1. clone cargo's repo:
cd /tmp
git clone https://github.com/rust-lang/cargo.git
cd cargo
2. checkout tag 0.76.0, or branch origin/rust-1.75.0
git checkout 0.76.0
3. manually edit this file ./src/cargo/core/workspace.rs at line 1118
or manually go to function:
pub fn emit_warnings(&self) -> CargoResult<()> {
right before that function's end which looks like:
Ok(())
}
so there at line 1118, insert above that Ok(()) something, doesn't matter
what, doesn't have to make sense, like:
if seen_any_warnings {
  //comment
  bail!("reasons");
}
save the file
4. try to generate a diff from it:
git diff > /tmp/foo.patch
you get this:
```diff
diff --git a/src/cargo/core/workspace.rs b/src/cargo/core/workspace.rs
index 4667c8029..8f0a74473 100644
--- a/src/cargo/core/workspace.rs
+++ b/src/cargo/core/workspace.rs
@@ -1115,6 +1115,10 @@ impl<'cfg> Workspace<'cfg> {
                 }
             }
         }
+        if seen_any_warnings {
+            //comment
+            bail!("reasons");
+        }
         Ok(())
     }

```
Now this is an ambiguous patch/hunk because if you try to apply this patch
on the same original file, cumulatively, it applies successfully in 3
different places, but we won't do that now.
5. now let's discard it(we already have it saved in /tmp/foo.patch) and
pretend that something changed in the original code:
git checkout .
git checkout 0.80.0
6. reapply that patch on the new changes:
git apply /tmp/foo.patch
(this shows no errors)
7. look at the diff, for no good reason, just to see that it's the
same(kind of):
git diff > /tmp/foo2.patch
contents:
```diff
diff --git a/src/cargo/core/workspace.rs b/src/cargo/core/workspace.rs
index 55bfb7a10..92709f224 100644
--- a/src/cargo/core/workspace.rs
+++ b/src/cargo/core/workspace.rs
@@ -1099,6 +1099,10 @@ impl<'gctx> Workspace<'gctx> {
                 }
             }
         }
+        if seen_any_warnings {
+            //comment
+            bail!("reasons");
+        }
         Ok(())
     }

```
8. now look at the file, where was the patch applied? that's right, it's at
the end of the wrong function:
fn validate_manifest(&mut self) -> CargoResult<()> {
vim src/cargo/core/workspace.rs +1040
jump at the end of it at line 1107, you see it's our patch there, applied
in the wrong spot!

Hopefully, depending on the change, this kind of patch which applied in the
wrong place, will be caught at (rust)compile time (in my case, it was this)
or worse, at (binary)runtime.

With the aforementioned `diffy` patch, the generated diff would actually be
with a context of 4, to make it unambiguous, so it would've been this:
```diff
--- original
+++ modified
@@ -1186,8 +1186,12 @@
                     self.gctx.shell().warn(msg)?
                 }
             }
         }
+        if seen_any_warnings {
+            //use anyhow::bail;
+            bail!("Compilation failed due to cargo warnings! Manually done
this(via cargo patch) so that things like the following (ie. dep key
packages= and using rust pre 1.26.0 which ignores it, downloads squatted
package) will be avoided in the future:
https://github.com/rust-lang/rust/security/advisories/GHSA-phjm-8x66-qw4r");
+        }
         Ok(())
     }

     pub fn emit_lints(&self, pkg: &Package, path: &Path) ->
CargoResult<()> {
```
this hunk is now unambiguous because it cannot be applied in more than 1
place in the original file, furthermore patching a modified future file
will fail(with that `diffy` patch, and ideally, with `git apply` if any
changes are implemented to "fix" this issue) if any of the hunks can be
independently(and during the full patch application too) applied in more
than 1 place.

I consider that I don't know enough to understand how `git diff`/`git
apply` works internally (and similarly, gnu `diff`/`patch`) to actually
change them and make them generate unambiguous hunks where only the hunks
that would've been ambiguous have increased context size, instead of the
whole patch have increased context size for all hunks(which is what I did
for `diffy` too so far, in that proof of concept patch), therefore if a
"fix" is deemed necessary(it may not be, as I might've missed something and
I'm unaware of it, so a fix may be messing other things up, who knows?!)
then I hope someone much more knowledgeable could implement it(maybe even
for gnu diff/patch too), and while I don't think that a "please" would be
enough, I'm still gonna say it: please do so, if so inclined.

Thank you for your time and consideration.
