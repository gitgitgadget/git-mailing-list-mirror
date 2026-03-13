Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB07038C406
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 12:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773405812; cv=none; b=Wg637nJ8yFHEkMJrbJlU3+7IyZlZyTTHEAOpROuzLUBBPrgICnSJthajPbQi6vtqrS30kpi1hqgnf/d4HQgdZ3XkGHbJCmlH4kN3gJ23NlhGrTI558gHcyfngc2tLF560kuVU3jiBFMt0L/EyT300KoP7gfjLRZkIw2MOW/LrL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773405812; c=relaxed/simple;
	bh=wRrCpOwv2FifnI0LDdzU1fOSHbJrdpJpSVHQLe67m8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzq9EaeEP5IsuEVyw0fApsOyA+hKmKiFjHP+evwfsBZ/APTftOjqZBDe2NgoxMDSuD/x2J1ZbVxiUomqXbr+19DiXyUlct6mBseSP1zoWm45svsXtf4c4DYzwOOiij++f8lOlv2qAsRZys/jo9RvRqSAujkO+uPL3lgm+P+2u8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNE9vtUr; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=paultarjan.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNE9vtUr"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cd8576a512so336765885a.0
        for <git@vger.kernel.org>; Fri, 13 Mar 2026 05:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773405809; x=1774010609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FX6gMjdv68+NGc+4YE8iI2SBwHVViFoMjJTEvyNATj4=;
        b=PNE9vtUrHPoYEXlSXy5nRdZxzcnDWGOcVu3YuA/aQ1tVu6e1ywC5YGLue5WSPJikoV
         acljaEy4ff203p39z9QbDq/qfrYr9onmMxnyOaRuWXLsrUD2v4c9Hp0hEK6hKF9VNyLW
         h4rqMahRTBBNpgX9nDECXnOTmbNDsZZt/+AYRmVeNYzIszeeAQfpuGEM1kmYBHdAuqm/
         9qS22/fR105pxkLo85E7Ybr0jwMplEyZfO/E9L0ygDfEcGCy2/2tsuHIjIyM2S3lHJxa
         CsUrHTNvSJUemNgq9FKtYTXE/T7FACLK55ZzP6VZZHiySkyuQtEfx/UtBY8EVdVt/EnX
         JQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773405809; x=1774010609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FX6gMjdv68+NGc+4YE8iI2SBwHVViFoMjJTEvyNATj4=;
        b=olr+5ElH8bOoMrq49ZqP0nt/V87VuGpWCy+OvTUvuvERtsy5LXOev8BCX9b85BwtHA
         oJZKTljiqynYT7SU59Y9ZTJdXO6z02KOzvn1KVhmbzfVlEAd5++qE4I500wuTKVHOSNO
         YpNRhy7NahpRgTKaIW7PjENQi3Bb3vVtkLOUmg1XB3KdJPJuqhvg/ZLEzHjm53w6ec0Z
         DfaldIeQhyUrzEThavo8C7NemYcdVoLH4wKWEA87gHzoa0Yq8iue8KRjzm4OCK38kHLd
         uOogIhYb5TfwsBNoG89srSkeMGDBH5GHTG6YtO6j/4fuzinHb8dpiDB5mbygx7+W2kTf
         I0uw==
X-Gm-Message-State: AOJu0YxTrHwWiPBDiRj19VgiCkzVFJthcU9tMcDsDE7sYUjQCQx/ZkVT
	DMn8qrOvdlC1I19ceGTV9F3sFSSIzSsDI7A4Sz9XaQ8ehm4SAzi1llT87oogJA==
X-Gm-Gg: ATEYQzxhUrfazfMcex6rCciU6ab/394E5w4l6YqLETCzijRLDsg2kYmOaP6RWqtdx8M
	3BTS6+nxKlRUkw/uFDsjLEgrHH+FJ2Yw2YgpHqFt/UsX8CLaCtdMtFRQr2wlSxxoIxQOOC8Fx+R
	3IB7sDVAvObvQnsLWSUO8n0Tc47yneeyE6QbhuftWpTJsg71QhtZ0fV9eMxJkDYLtuoTqHMCPsN
	Hiz0wBZc7IDE9X3D5sdEKZec9qZDL80gRGzqco99drrqX2KLVZNnzdwnWPhUhp2h9j4Wu13oO8s
	iSI3N9HmO6XN1VV+q2X65INa77ZqF5BuGwPczEtDELGoVbHWjEdbesg9BsvaJrbUkVfDCzmxbbW
	IM5oIOWvf+Q+uZaml/IYw3TJD1B113jC6FmHO/r263cDlGgoPHlwJciIlS1VWtQ10BFT8JSw9Xv
	h4ER9K2WUbl7KR2vFus6tQc/DO+RGCmkAln1JjbUwlMCvJmVIXyTHGHLY1ooNAdqBohIP/f4mHc
	/grmAiD0PMcY7mpXDap
X-Received: by 2002:a05:620a:4621:b0:8cd:aa5c:5425 with SMTP id af79cd13be357-8cdaa7dfd34mr834849585a.18.1773405809249;
        Fri, 13 Mar 2026 05:43:29 -0700 (PDT)
Received: from localhost.localdomain (d75-158-111-22.abhsia.telus.net. [75.158.111.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda215c2a9sm548508685a.46.2026.03.13.05.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 05:43:28 -0700 (PDT)
Sender: Paul Tarjan <ptarjan@gmail.com>
From: Paul Tarjan <paul@paultarjan.com>
X-Google-Original-From: Paul Tarjan <github@paulisageek.com>
To: git@vger.kernel.org
Cc: peff@peff.net,
	ps@pks.im,
	gitgitgadget@gmail.com,
	christian.couder@gmail.com,
	hanxin.hx@bytedance.com
Subject: Re: [PATCH v3] promisor-remote: prevent lazy-fetch recursion in child fetch
Date: Fri, 13 Mar 2026 06:43:25 -0600
Message-ID: <20260313124326.75586-1-github@paulisageek.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313014315.GA3201544@coredump.intra.peff.net>
References: <20260313014315.GA3201544@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jeff King <peff@peff.net> writes:

> It would be nice to confirm that's what's going on, though (and it isn't
> really a thin pack). If the problem can be reproduced, I don't suppose
> we have a GIT_TRACE_PACKET output from a failing instance? That would
> confirm that we're correctly using the noop negotiation.

Yeah. I couldn't capture one live during the incident, but I did a
clean-room reproduction afterward: empty bare repo, git remote add
origin pointing at the same GitHub monorepo, then the exact argv
from fetch_objects() with a tree SHA pulled from one of the
.promisor sidecars written during the incident:

  $ git -c fetch.negotiationAlgorithm=noop fetch origin \
        --no-tags --no-write-fetch-head --recurse-submodules=no \
        --filter=blob:none --stdin <<< "$TREE_OID"

  packet:        fetch< version 2
  packet:        fetch< agent=git/github-94ec3a8682aa-Linux
  packet:        fetch< ls-refs=unborn
  packet:        fetch< fetch=shallow wait-for-done filter
  packet:        fetch< server-option
  packet:        fetch< object-format=sha1
  packet:        fetch< 0000
  packet:        fetch> command=fetch
  packet:        fetch> agent=git/2.51.2-Linux
  packet:        fetch> object-format=sha1
  packet:        fetch> 0001
  packet:        fetch> thin-pack
  packet:        fetch> no-progress
  packet:        fetch> ofs-delta
  packet:        fetch> filter blob:none
  packet:        fetch> want 086faa42a038f2e4a1b5e395cde544f8f3c6a9a5
  packet:        fetch> done
  packet:        fetch> 0000
  packet:        fetch< packfile
  packet:     sideband< PACK ...
  packet:     sideband< 0000

Zero have lines, noop negotiation doing its thing.

Two interesting bits:

1. The client sends thin-pack unconditionally (fetch-pack.c doesn't
   check what negotiation algorithm is in use). So the server is
   allowed to send a thin pack. With zero haves it has nothing to
   thin against, but nothing on the wire actually forbids it.

2. filter blob:none is on the wire -- hardcoded by fetch_objects().
   Combined with thin-pack, this gives the server a way to end up
   omitting an object that happens to be a delta base.

For this particular tree GitHub responded cleanly (5 trees, no
deltas, 2701 bytes), so whatever triggers the REF_DELTA depends on
the specific objects being fetched and how they're stored
server-side.

> But it _can_ send deltas against objects which are part of the backfill
> itself. Normally we'd send those as OFS_DELTA, because they're both in
> the same output pack. But there are cases where we might not:
>
>   - the verbatim pack-reuse code will sometimes rewrite ofs-delta into
>     ref-delta. I don't remember all of the cases where this might
>     happen. Certainly if the client hasn't claimed to support
>     ofs-deltas, but I think maybe some other cases? I'd have to dig into
>     it.

I think it's (b). What's interesting is that Jonathan Tan flagged
exactly this risk when he introduced the prefetch call.
8a30a1efd1 ("index-pack: prefetch missing REF_DELTA bases",
2019-05-14):

    Support for lazy fetching should still generally be turned off
    in index-pack because it is used as part of the lazy fetching
    process itself (if not, infinite loops may occur), but we do
    need to fetch the REF_DELTA bases. (When fetching REF_DELTA
    bases, it is unlikely that those are REF_DELTA themselves,
    because we do not send "have" when making such fetches.)

So the "infinite loops may occur" door was left open deliberately,
on the argument that it's unlikely. My patch just closes it.

Here's what I think went wrong in practice: fetch_objects()
hardcodes --filter=blob:none. When the want is a tree, the server
walks tree reachability and assembles potentially millions of tree
objects with no blobs. If pack-reuse passes through an object
stored server-side as OFS_DELTA against a blob, it comes out as
REF_DELTA and the blob base gets filtered out by blob:none.

I have a live ps snapshot from the incident showing the chain:

  3719679  git -c fetch.negotiationAlgorithm=noop fetch origin \
               --no-tags --no-write-fetch-head \
               --recurse-submodules=no --filter=blob:none --stdin
  3725911  git index-pack --stdin --fix-thin --keep=fetch-pack \
               3719679 on <host> --promisor --pack_header=2,7535361
  3726936  git -c fetch.negotiationAlgorithm=noop fetch origin \
               --no-tags --no-write-fetch-head \
               --recurse-submodules=no --filter=blob:none --stdin

--keep embeds the parent PID, so the chain is clear: lazy-fetch
(3719679) -> index-pack (3725911, 7,535,361 objects) -> depth-2
lazy-fetch (3726936). 7.5M objects is about right for wanting a
single tree with no haves and filter=blob:none -- you get the
entire commit+tree closure minus blobs. One REF_DELTA against a
filtered blob in 7.5M objects and you're recursing.

> Now there's a catch: the pack is not really thin, and so index-pack
> should not need to do an extra backfill request in order to get the base
> object.

Actually, the pack IS thin in this case -- the REF_DELTA's base is
a blob that the server filtered out because of blob:none. The base
isn't in the pack at all. fix_unresolved_deltas() correctly sees it
as unresolved and calls promisor_remote_get_direct().

> If that's what is happening, then I _think_ Paul's patch will do the
> right thing. We'd say "no, we don't have that object" without doing the
> backfill, and then eventually find it as part of the final resolution.

Right, that's what happens. The child hits the guard at the top of
fetch_objects() and bails with "lazy fetching disabled". The
depth-1 index-pack can't resolve the delta, which is the correct
outcome -- retrying the same noop fetch would just get the same
response.

I also wrote a deterministic local reproducer (no network needed)
that shows the recursion directly. Two scripts, needs python3 + git,
works on Linux and macOS. Ran it just now:

repro-depth1.sh sets up a local bare server with two similar blobs,
a blob:none partial-clone client, and a hand-crafted 68-byte thin
pack with one REF_DELTA against a promised-but-absent blob:

  === without GIT_NO_LAZY_FETCH (current git) ===
  index-pack invocations: 2
  lazy-fetch spawns:      1

  === with GIT_NO_LAZY_FETCH=1 (what the patch sets) ===
  index-pack invocations: 1
  lazy-fetch spawns:      0

repro-unbounded.sh goes further: uploadpack.packObjectsHook always
returns the same thin pack, so every lazy-fetch spawns another.
Watchdog kills it at depth 50:

  === without patch ===
  recursion depth reached: 55
  index-pack invocations:  55
  tmp_pack_* on disk:      55

  === with GIT_NO_LAZY_FETCH=1 (the patch) ===
  recursion depth:         0
  index-pack invocations:  1
  tmp_pack_* on disk:      0

Those tmp_pack_* files are the disk growth -- each index-pack
streams to a tmpfile, blocks in fix_unresolved_deltas() to
lazy-fetch the base, and never gets to rename it. In the real
incident each was ~1.4 GB.

Scripts below.

--- >8 --- repro-depth1.sh --- >8 ---

#!/bin/bash
# Deterministic depth-1 recursion proof for promisor-remote lazy-fetch bug.
# No network. Runs in ~1 second.
#
# Mechanism:
#   - Local bare server with two similar blobs; client is a blob:none
#     partial clone (both blobs promised, neither local).
#   - Craft a 68-byte thin pack by hand: one REF_DELTA object whose base
#     SHA is one of the promised-but-absent blobs.
#   - Feed to `git -C client index-pack --stdin --fix-thin`.
#   - fix_unresolved_deltas() sees the unresolved REF_DELTA, calls
#     promisor_remote_get_direct() for the base, which spawns
#     `git -c fetch.negotiationAlgorithm=noop fetch ... --stdin`.
#   - That child fetch spawns its own index-pack --fix-thin.
#   - GIT_TRACE shows the nested spawn.

set -euo pipefail

W="${TMPDIR:-/tmp}/promisor-recursion-demo"
rm -rf "$W"; mkdir -p "$W"; cd "$W"

git -c init.defaultBranch=main init -q --bare server.git
git -C server.git config uploadpack.allowFilter true
git -C server.git config uploadpack.allowAnySHA1InWant true
git -c init.defaultBranch=main init -q work
(
    cd work
    python3 -c "print('\n'.join('shared line %d ' * 4 % (i,i,i,i) for i in range(200)))" > f
    git add f; git commit -qm base
    python3 -c "print('\n'.join('shared line %d ' * 4 % (i,i,i,i) for i in range(200))); print('extra')" > f
    git add f; git commit -qm delta
    git push -q ../server.git main
)

printf '%s\n%s\n' "$(git -C work rev-parse HEAD~1:f)" "$(git -C work rev-parse HEAD:f)" | \
    git -C server.git pack-objects --stdout --delta-base-offset > both.pack

python3 << 'PYEOF'
import struct, zlib, hashlib

with open('both.pack', 'rb') as f:
    data = f.read()
assert data[:4] == b'PACK' and struct.unpack('>I', data[8:12])[0] == 2

def parse_hdr(data, pos):
    b = data[pos]; otype = (b >> 4) & 7; sz = b & 0xf; sh = 4; p = pos
    while b & 0x80:
        p += 1; b = data[p]; sz |= (b & 0x7f) << sh; sh += 7
    return otype, sz, p + 1

def zlib_end(data, pos):
    d = zlib.decompressobj(); p = pos
    while p < len(data):
        chunk = data[p:p+512]; d.decompress(chunk)
        if d.unused_data: return p + len(chunk) - len(d.unused_data)
        if d.eof: return p + len(chunk)
        p += len(chunk)
    return p

t1, s1, d1 = parse_hdr(data, 12)
if t1 == 6:
    p = d1; b = data[p]; p += 1
    while b & 0x80: b = data[p]; p += 1
    e1 = zlib_end(data, p)
else:
    e1 = zlib_end(data, d1)
t2, s2, d2 = parse_hdr(data, e1)

if t1 == 3 and t2 == 6:
    base_raw = zlib.decompress(data[d1:e1])
    delta_sz, delta_hdr_end = s2, d2
elif t1 == 6 and t2 == 3:
    base_raw = zlib.decompress(data[d2:zlib_end(data, d2)])
    delta_sz, delta_hdr_end = s1, d1
else:
    raise SystemExit(f"expected one blob + one OFS_DELTA, got types {t1},{t2}")

base_sha = hashlib.sha1(f"blob {len(base_raw)}\0".encode() + base_raw).digest()

p = delta_hdr_end; b = data[p]; p += 1
while b & 0x80: b = data[p]; p += 1
delta_zlib = data[p:zlib_end(data, p)]

sz = delta_sz
hb = [(7 << 4) | (sz & 0xf)]; sz >>= 4
while sz: hb[-1] |= 0x80; hb.append(sz & 0x7f); sz >>= 7
thin = b'PACK' + struct.pack('>II', 2, 1) + bytes(hb) + base_sha + delta_zlib
thin += hashlib.sha1(thin).digest()
with open('thin.pack', 'wb') as f: f.write(thin)
print(f"thin.pack: {len(thin)} bytes, REF_DELTA base={base_sha.hex()}")
PYEOF

git clone -q --no-local --filter=blob:none --no-checkout "file://$W/server.git" client

echo "=== without GIT_NO_LAZY_FETCH (current git) ==="
GIT_TRACE="$W/trace.txt" \
    git -C client index-pack --stdin --fix-thin < thin.pack >/dev/null 2>&1 || true
grep -E 'built-in: git (index-pack|fetch)|run_command:.*negotiationAlgorithm' trace.txt
echo "index-pack invocations: $(grep -c 'built-in: git index-pack' trace.txt)"
echo "lazy-fetch spawns:      $(grep -c 'run_command:.*negotiationAlgorithm=noop' trace.txt)"

echo ""
echo "=== with GIT_NO_LAZY_FETCH=1 (what the patch sets) ==="
rm -rf client
git clone -q --no-local --filter=blob:none --no-checkout "file://$W/server.git" client
GIT_NO_LAZY_FETCH=1 GIT_TRACE="$W/trace2.txt" \
    git -C client index-pack --stdin --fix-thin < thin.pack 2>&1 || true
echo "index-pack invocations: $(grep -c 'built-in: git index-pack' trace2.txt)"
echo "lazy-fetch spawns:      $(grep -c 'run_command:.*negotiationAlgorithm=noop' trace2.txt || echo 0)"

--- >8 --- repro-unbounded.sh --- >8 ---

#!/bin/bash
# Unbounded recursion proof. Run repro-depth1.sh first.
# uploadpack.packObjectsHook always returns the same thin pack,
# so every lazy-fetch spawns another. Watchdog kills at depth 50.

set -uo pipefail

W="${TMPDIR:-/tmp}/promisor-recursion-demo"
cd "$W"
test -f thin.pack || { echo "run repro-depth1.sh first"; exit 1; }

cat > evil-pack-objects.sh << EOF
#!/bin/sh
cat > /dev/null
cat "$W/thin.pack"
EOF
chmod +x evil-pack-objects.sh

cat > fake-global.gitconfig << EOF
[uploadpack]
    packObjectsHook = $W/evil-pack-objects.sh
EOF

rm -rf client
GIT_CONFIG_GLOBAL= git clone -q --no-local --filter=blob:none --no-checkout \
    "file://$W/server.git" client

TRACE="$W/unbounded.trace"
rm -f "$TRACE"

echo "=== spawning (watchdog kills at depth 50) ==="
GIT_TRACE="$TRACE" GIT_CONFIG_GLOBAL="$W/fake-global.gitconfig" \
    git -C client index-pack --stdin --fix-thin < thin.pack >/dev/null 2>&1 &
ROOT=$!

LIMIT=50
while kill -0 "$ROOT" 2>/dev/null; do
    N=$(grep -c 'run_command:.*negotiationAlgorithm=noop' "$TRACE" 2>/dev/null || true)
    N=${N:-0}
    if (( N >= LIMIT )); then
        echo ">>> depth $N reached, killing process tree $ROOT <<<"
        pkill -KILL -f "promisor-recursion-demo/client" 2>/dev/null || true
        kill -KILL "$ROOT" 2>/dev/null || true
        sleep 0.2
        pkill -KILL -f "promisor-recursion-demo/client" 2>/dev/null || true
        break
    fi
    sleep 0.02
done
wait "$ROOT" 2>/dev/null
EC=$?

DEPTH=$(grep -c 'run_command:.*negotiationAlgorithm=noop' "$TRACE" 2>/dev/null || true)
DEPTH=${DEPTH:-0}
IPACKS=$(grep -c 'built-in: git index-pack' "$TRACE" 2>/dev/null || true)
IPACKS=${IPACKS:-0}
TMPS=$(ls client/.git/objects/pack/tmp_pack_* 2>/dev/null | wc -l | tr -d ' ')

echo ""
echo "=== without patch (root exit $EC) ==="
echo "recursion depth reached: $DEPTH"
echo "index-pack invocations:  $IPACKS"
echo "tmp_pack_* on disk:      $TMPS"
echo ""
echo "first 4 + last 2 spawns (identical line, no termination condition):"
grep -E 'built-in: git index-pack|run_command:.*negotiationAlgorithm=noop' "$TRACE" | head -4
echo "..."
grep -E 'built-in: git index-pack|run_command:.*negotiationAlgorithm=noop' "$TRACE" | tail -2

echo ""
echo "=== with GIT_NO_LAZY_FETCH=1 (the patch) ==="
rm -rf client; rm -f "$TRACE"
GIT_CONFIG_GLOBAL= git clone -q --no-local --filter=blob:none --no-checkout \
    "file://$W/server.git" client
GIT_NO_LAZY_FETCH=1 GIT_TRACE="$TRACE" GIT_CONFIG_GLOBAL="$W/fake-global.gitconfig" \
    git -C client index-pack --stdin --fix-thin < thin.pack 2>&1 || true
CTRL_DEPTH=$(grep -c 'run_command:.*negotiationAlgorithm=noop' "$TRACE" 2>/dev/null || true)
CTRL_IPACKS=$(grep -c 'built-in: git index-pack' "$TRACE" 2>/dev/null || true)
CTRL_TMPS=$(ls client/.git/objects/pack/tmp_pack_* 2>/dev/null | wc -l | tr -d ' ')
echo "recursion depth:         ${CTRL_DEPTH:-0}"
echo "index-pack invocations:  ${CTRL_IPACKS:-0}"
echo "tmp_pack_* on disk:      $CTRL_TMPS"

rm -rf "$W/client"

Paul
