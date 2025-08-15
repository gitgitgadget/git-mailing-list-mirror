Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8986C1D416C
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 01:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755220992; cv=none; b=reJdWNLKsg8rSm+dsm6FzzddtcP9ERMVpj1hLIkkjx5OTA6xBB1ZRovy/W9TG9nol15KPJl1y/Vi6Sl3lCZ6HAfNTs0TqCMrpN9nY8GDWUsBKW9t6vlKjw50IOQNj/LmWBz9KiJ/w7CMfJdz8FGCheV2FbIgDSqunHeI32IyE/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755220992; c=relaxed/simple;
	bh=ZZwcrA+CLA4kcb09L9wR0QzxlYlEe9tzrvet8CzoFOI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=k7D3Qqk0QTB1Frr5uFUPvUX+BGPCv+gFtyN0mS+zHtlIp+cXXhA8Xqp0C30pGWhoXTNz+QqlsD3/6D6NyZdYvz6bDP/eHO8tFRUaViEA8JOPdUK75/81I0gPwzzaU7jrBFwkGJlb6ylx2x2fMEaSYmzugAVWrShrXDLj4FnZ7co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmQgIp98; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmQgIp98"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b916fda762so1232235f8f.0
        for <git@vger.kernel.org>; Thu, 14 Aug 2025 18:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755220988; x=1755825788; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3KEs3WT7c+uKiGRMDvOeCFORLCQowTzKv0PRx84Dow=;
        b=SmQgIp98GiWtEyYi3t6Ns1ZeUgVbc0rXf0CRp9Eas5Flt2jreHOiPs4bXQf/r/rXCm
         QoNa23R8fEsTOYdhVw77byNERMeRRDxrQK4NGrZgFi5mbMLWnkBOHhjrs5hoq0LC8Ssz
         ck6DFa82eoQ2DtWDmaMhQTYFiDzpth26WI5WvdfCAPCfNNO38MC9XElKZgbe4dx8NjvZ
         qFzEnFAhWcc78WVlCZcfEoTaLSzvEYb+95+EYSwD7NshKaY6V8hMyC3TuEYnk2oeIssc
         YtumEXgXmRPk7cOsGglNXTspFxhyv8PqsWz5vQvqdQ3TEo31iZpVpCcqVlx2MSTO7Zmn
         hfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755220988; x=1755825788;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3KEs3WT7c+uKiGRMDvOeCFORLCQowTzKv0PRx84Dow=;
        b=O0NLRh0eHW3s6ubhjltlNTNze4VAmR1gqD20fM/+vur0yf54tcbtesjz7NkD04myBI
         qhtKStUq5GT8nIx0oLonZTjPvy5ayRAcjtikhCZzHtlrrvFfKg4q5qoSa8I3rFQ1XWba
         mtlDU7yoZCv7BRI9SG4ePm4INjqB0lolMjrYP3pH8rjufrC3SCuE8ccqEHoBUuqHzf9O
         ofnsQLWzS0IV2qxIjZJVxLsCaScZfv1Vp4wPMNI0T2TvKVJ8BzaM+0/VFEIHEnfLeF1t
         n/UGd2QeS+7SahZ/ZnVQG9ZALm931Ieh2SsLJvGZNNO/6yI372w5nsYEI9PqK6DDAd6B
         f+vQ==
X-Gm-Message-State: AOJu0YxRhDdaRnOVPgGVRC/TeFOwb3Gy5bxyx4jq9xjkh+BmBVjlDrfK
	djWgZEq6oDQIXEWYhq9YWx8q8tG3UWm7N8kZAwKeMmfybpBEIB4Cby0DeL43Zw==
X-Gm-Gg: ASbGnctlQTVenix+pTocBTIyWtRYYARAy8I/VpZVS2RMoCE/9b7HPNKFEwyWPkqWuIo
	Seqv6P9N/aMrkFwp6zzgFiVEJ1rJK5ZFv5tcjyOlxPG8aoUTDaIiZGrIlhs9uJ/XQoWetzU7NyE
	pJqj+z6zvyceH/IiEEwQNH809nnlFI1xozUGBIzGvlmWivUB1ZddqTZsCc0W2bvPf6sutr4EAe4
	FvicPRjznZo8bU/BFPIOuFEX6svmKedLG7Zz+9GRl1JGUF2XKMajxSNfKLUfRTL84eC9ONsxvJT
	KuGwRZ0he3vysmoGeSAP/bs82l75sjXDUJrx9bDfK0hHHM4IttHCRtqKeCNAgLLMekGI6b+G6xp
	Han37FC8qax6WOQizMUufMUSNSLQHWf9YsQ==
X-Google-Smtp-Source: AGHT+IEYMlU5jbyH0FHL7Gv/SNL9ugULkKhpjRZ9xqpSs8KmScpco7YkAzCu8+o5LH9GxPuGt7ueaw==
X-Received: by 2002:a05:6000:4029:b0:3b7:95ac:6f55 with SMTP id ffacd0b85a97d-3bb4cc79c25mr279899f8f.20.1755220987718;
        Thu, 14 Aug 2025 18:23:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb676c9b1csm106566f8f.45.2025.08.14.18.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 18:23:07 -0700 (PDT)
Message-Id: <f20efdff7aa0a02ca2585de0cd9de21bbff22d58.1755220973.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
	<pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 01:22:49 +0000
Subject: [PATCH v2 14/17] xdiff: implement a white space iterator in Rust
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Taylor Blau <me@ttaylorr.com>,
    Christian Brabandt <cb@256bit.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Eli Schwartz <eschwartz@gentoo.org>,
    "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Matthias =?UTF-8?Q?A=C3=9Fhauer?= <mha1993@live.de>,
    Patrick Steinhardt <ps@pks.im>,
    Sam James <sam@gentoo.org>,
    Collin Funk <collin.funk1@gmail.com>,
    Mike Hommey <mh@glandium.org>,
    Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
    Ben Knoble <ben.knoble@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

Xdiff has traditionally implemented the logic for iterating over
whitespace in every location that needed to do so. Create a consolidated
iterator in Rust that we can call from each location. Write Rust unit
tests to ensure the correctness of the Rust whitespace iterator and the
chunked_iter_equal() function.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 rust/xdiff/src/lib.rs    |  10 ++
 rust/xdiff/src/xutils.rs | 292 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 302 insertions(+)
 create mode 100644 rust/xdiff/src/xutils.rs

diff --git a/rust/xdiff/src/lib.rs b/rust/xdiff/src/lib.rs
index 96975975a1ba..9cf0462bcdb9 100644
--- a/rust/xdiff/src/lib.rs
+++ b/rust/xdiff/src/lib.rs
@@ -1,3 +1,13 @@
+pub mod xutils;
+
+pub const XDF_IGNORE_WHITESPACE: u64 = 1 << 1;
+pub const XDF_IGNORE_WHITESPACE_CHANGE: u64 = 1 << 2;
+pub const XDF_IGNORE_WHITESPACE_AT_EOL: u64 = 1 << 3;
+pub const XDF_IGNORE_CR_AT_EOL: u64 = 1 << 4;
+pub const XDF_WHITESPACE_FLAGS: u64 = XDF_IGNORE_WHITESPACE |
+    XDF_IGNORE_WHITESPACE_CHANGE |
+    XDF_IGNORE_WHITESPACE_AT_EOL |
+    XDF_IGNORE_CR_AT_EOL;
 
 
 #[no_mangle]
diff --git a/rust/xdiff/src/xutils.rs b/rust/xdiff/src/xutils.rs
new file mode 100644
index 000000000000..38126b47292f
--- /dev/null
+++ b/rust/xdiff/src/xutils.rs
@@ -0,0 +1,292 @@
+use crate::*;
+
+pub(crate) fn xdl_isspace(v: u8) -> bool {
+    match v {
+        b'\t' | b'\n' | b'\r' | b' ' => true,
+        _ => false,
+    }
+}
+
+pub struct WhitespaceIter<'a> {
+    line: &'a [u8],
+    index: usize,
+    flags: u64,
+}
+
+
+impl<'a> WhitespaceIter<'a> {
+    pub fn new(line: &'a [u8], flags: u64) -> Self {
+        Self {
+            line,
+            index: 0,
+            flags,
+        }
+    }
+}
+
+impl<'a> Iterator for WhitespaceIter<'a> {
+    type Item = &'a [u8];
+
+    fn next(&mut self) -> Option<Self::Item> {
+        if self.index >= self.line.len() {
+            return None;
+        }
+
+        loop {
+            let start = self.index;
+            if self.index == self.line.len() {
+                return None;
+            }
+
+            /* return contiguous run of not space bytes */
+            while self.index < self.line.len() {
+                if xdl_isspace(self.line[self.index]) {
+                    break;
+                }
+                self.index += 1;
+            }
+            if self.index > start {
+                return Some(&self.line[start..self.index]);
+            }
+            /* the current byte had better be a space */
+            if !xdl_isspace(self.line[self.index]) {
+                panic!("xdl_line_iter_next xdl_isspace() is false")
+            }
+
+            while self.index < self.line.len() && xdl_isspace(self.line[self.index]) {
+                self.index += 1;
+            }
+
+
+            if self.index <= start {
+                panic!("xdl_isspace() cannot simultaneously be true and false");
+            }
+
+            if (self.flags & XDF_IGNORE_WHITESPACE_AT_EOL) != 0
+                && self.index == self.line.len()
+            {
+                return None;
+            }
+            if (self.flags & XDF_IGNORE_WHITESPACE) != 0 {
+                continue;
+            }
+            if (self.flags & XDF_IGNORE_WHITESPACE_CHANGE) != 0 {
+                if self.index == self.line.len() {
+                    continue;
+                }
+                return Some(" ".as_bytes());
+            }
+            if (self.flags & XDF_IGNORE_CR_AT_EOL) != 0 {
+                if start < self.line.len() && self.index == self.line.len() {
+                    let mut end = self.line.len();
+                    if end > 0 && self.line[end - 1] == b'\n' {
+                        if end - start == 1 {
+                            return Some(&self.line[start..end]);
+                        } else {
+                            end -= 1;
+                        }
+                        if end > 0 && self.line[end - 1] == b'\r' {
+                            self.index = end;
+                            end -= 1;
+                            if end - start == 0 {
+                                continue;
+                            }
+                            return Some(&self.line[start..end]);
+                        }
+                    }
+                }
+            }
+            return Some(&self.line[start..self.index]);
+        }
+    }
+}
+
+pub fn chunked_iter_equal<'a, T, IT0, IT1>(mut it0: IT0, mut it1: IT1) -> bool
+where
+    T: Eq + 'a,
+    IT0: Iterator<Item = &'a [T]>,
+    IT1: Iterator<Item = &'a [T]>,
+{
+    let mut run_option0: Option<&[T]> = it0.next();
+    let mut run_option1: Option<&[T]> = it1.next();
+    let mut i0 = 0;
+    let mut i1 = 0;
+
+    while let (Some(run0), Some(run1)) = (run_option0, run_option1) {
+        while i0 < run0.len() && i1 < run1.len() {
+            if run0[i0] != run1[i1] {
+                return false;
+            }
+
+            i0 += 1;
+            i1 += 1;
+        }
+
+        if i0 == run0.len() {
+            i0 = 0;
+            run_option0 = it0.next();
+        }
+        if i1 == run1.len() {
+            i1 = 0;
+            run_option1 = it1.next();
+        }
+    }
+
+    while let Some(run0) = run_option0 {
+        if run0.len() == 0 {
+            run_option0 = it0.next();
+        } else {
+            break;
+        }
+    }
+
+    while let Some(run1) = run_option1 {
+        if run1.len() == 0 {
+            run_option1 = it1.next();
+        } else {
+            break;
+        }
+    }
+
+    run_option0.is_none() && run_option1.is_none()
+}
+
+#[cfg(test)]
+mod tests {
+    use crate::*;
+    use crate::xutils::{chunked_iter_equal, WhitespaceIter};
+
+    fn extract_string<'a>(line: &[u8], flags: u64, buffer: &'a mut Vec<u8>) -> &'a str {
+        let it = WhitespaceIter::new(line, flags);
+        buffer.clear();
+        for run in it {
+            #[cfg(test)]
+            let _view = unsafe { std::str::from_utf8_unchecked(run) };
+            buffer.extend_from_slice(run);
+        }
+        unsafe { std::str::from_utf8_unchecked(buffer.as_slice()) }
+    }
+
+    fn get_str_it<'a>(slice: &'a [&'a str]) -> impl Iterator<Item = &'a [u8]> + 'a {
+        slice.iter().map(|v| (*v).as_bytes())
+    }
+
+    #[test]
+    fn test_ignore_space() {
+        let tv_individual = vec![
+            ("ab\r", "ab\r", XDF_IGNORE_CR_AT_EOL),
+            ("ab \r", "ab \r", XDF_IGNORE_CR_AT_EOL),
+            ("\r \t a \r", "\r \t a \r", XDF_IGNORE_CR_AT_EOL),
+            ("\r a \r", "\r a \r", XDF_IGNORE_CR_AT_EOL),
+            ("\r", "\r", XDF_IGNORE_CR_AT_EOL),
+            ("", "", XDF_IGNORE_CR_AT_EOL),
+            ("\r a \r", "\r a \r", XDF_IGNORE_CR_AT_EOL),
+
+            ("\r \t a \n", "\r \t a \r\n", XDF_IGNORE_CR_AT_EOL),
+            ("\r a \n", "\r a \r\n", XDF_IGNORE_CR_AT_EOL),
+            ("\n", "\r\n", XDF_IGNORE_CR_AT_EOL),
+            ("\n", "\n", XDF_IGNORE_CR_AT_EOL),
+            ("\r a \n", "\r a \n", XDF_IGNORE_CR_AT_EOL),
+
+            ("1\n", "1\r\n", XDF_IGNORE_CR_AT_EOL),
+            ("1", "1\r\n", XDF_IGNORE_WHITESPACE_CHANGE),
+
+            ("\r \t a \r\n", "\r \t a \r\n", 0),
+            ("\r a \r\n", "\r a \r\n", 0),
+            ("\r\n", "\r\n", 0),
+            ("\n", "\n", 0),
+            ("\r a \n", "\r a \n", 0),
+            ("     \n", "     \n", 0),
+            ("a     \n", "a     \n", 0),
+            ("  a  \t  asdf  \t \r\n", "  a  \t  asdf  \t \r\n", 0),
+            ("\t a  b  \t \n", "\t a  b  \t \n", 0),
+            ("  a b \t \r\n", "  a b \t \r\n", 0),
+            ("\t  a \n", "\t  a \n", 0),
+            ("\t\t\ta\t\n", "\t\t\ta\t\n", 0),
+            ("a\n", "a\n", 0),
+            ("\ta\n", "\ta\n", 0),
+
+            ("a", "\r \t a \r\n", XDF_IGNORE_WHITESPACE),
+            ("a", "\r a \r\n", XDF_IGNORE_WHITESPACE),
+            ("", "\r\n", XDF_IGNORE_WHITESPACE),
+            ("", "\n", XDF_IGNORE_WHITESPACE),
+            ("a", "\r a \n", XDF_IGNORE_WHITESPACE),
+            ("", "     \n", XDF_IGNORE_WHITESPACE),
+            ("a", "a     \n", XDF_IGNORE_WHITESPACE),
+            ("aasdf", "  a  \t  asdf  \t \r\n", XDF_IGNORE_WHITESPACE),
+            ("ab", "\t a  b  \t \n", XDF_IGNORE_WHITESPACE),
+            ("ab", "  a b \t \r\n", XDF_IGNORE_WHITESPACE),
+            ("a", "\t  a \n", XDF_IGNORE_WHITESPACE),
+            ("a", "\t\t\ta\t\n", XDF_IGNORE_WHITESPACE),
+            ("a", "a\n", XDF_IGNORE_WHITESPACE),
+            ("a", "\ta\n", XDF_IGNORE_WHITESPACE),
+
+            ("", "     \n", XDF_IGNORE_WHITESPACE_AT_EOL),
+            ("a", "a     \n", XDF_IGNORE_WHITESPACE_AT_EOL),
+            ("  a  \t  asdf", "  a  \t  asdf  \t \r\n", XDF_IGNORE_WHITESPACE_AT_EOL),
+            ("\t a  b", "\t a  b  \t \n", XDF_IGNORE_WHITESPACE_AT_EOL),
+
+            (" a b", "  a b \t \r\n", XDF_IGNORE_WHITESPACE_CHANGE),
+            (" a", "\t  a \n", XDF_IGNORE_WHITESPACE_CHANGE),
+            (" a", "\t\t\ta\t\n", XDF_IGNORE_WHITESPACE_CHANGE),
+            ("a", "a\n", XDF_IGNORE_WHITESPACE_CHANGE),
+            (" a", "\ta\n", XDF_IGNORE_WHITESPACE_CHANGE),
+
+            ("ab", "  a b \t \r\n", XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE),
+            ("a", "\t  a \n", XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE),
+            ("a", "\t\t\ta\t\n", XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE),
+            ("a", "a\n", XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE),
+            ("a", "\ta\n", XDF_IGNORE_WHITESPACE | XDF_IGNORE_WHITESPACE_CHANGE),
+        ];
+
+        let mut buffer = Vec::<u8>::new();
+        for (expected, input, flags) in tv_individual {
+            let actual = extract_string(input.as_bytes(), flags, &mut buffer);
+            assert_eq!(expected, actual, "input: {:?} flags: 0x{:x}", input, flags);
+        }
+    }
+
+    #[test]
+    fn test_chunked_iter_equal() {
+        let tv_str: Vec<(Vec<&str>, Vec<&str>)> = vec![
+            /* equal cases */
+            (vec!["", "", "abc"],         vec!["", "abc"]),
+            (vec!["c", "", "a"],          vec!["c", "a"]),
+            (vec!["a", "", "b", "", "c"], vec!["a", "b", "c"]),
+            (vec!["", "", "a"],           vec!["a"]),
+            (vec!["", "a"],               vec!["a"]),
+            (vec![""],                    vec![]),
+            (vec!["", ""],                vec![""]),
+            (vec!["a"],                   vec!["", "", "a"]),
+            (vec!["a"],                   vec!["", "a"]),
+            (vec![],                      vec![""]),
+            (vec![""],                    vec!["", ""]),
+            (vec!["hello ", "world"],     vec!["hel", "lo wo", "rld"]),
+            (vec!["hel", "lo wo", "rld"], vec!["hello ", "world"]),
+            (vec!["hello world"],         vec!["hello world"]),
+            (vec!["abc", "def"],          vec!["def", "abc"]),
+            (vec![],                      vec![]),
+
+            /* different cases */
+            (vec!["abc"],       vec![]),
+            (vec!["", "", ""],  vec!["", "a"]),
+            (vec!["", "a"],     vec!["b", ""]),
+            (vec!["abc"],       vec!["abc", "de"]),
+            (vec!["abc", "de"], vec!["abc"]),
+            (vec![],            vec!["a"]),
+            (vec!["a"],         vec![]),
+            (vec!["abc", "kj"], vec!["abc", "de"]),
+        ];
+
+        for (lhs, rhs) in tv_str.iter() {
+            let a: Vec<u8> = get_str_it(lhs).flatten().copied().collect();
+            let b: Vec<u8> = get_str_it(rhs).flatten().copied().collect();
+            let expected = a.as_slice() == b.as_slice();
+
+            let it0 = get_str_it(lhs);
+            let it1 = get_str_it(rhs);
+            let actual = chunked_iter_equal(it0, it1);
+            assert_eq!(expected, actual);
+        }
+    }
+}
-- 
gitgitgadget

