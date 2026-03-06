Received: from avasout-ptp-003.plus.net (avasout-ptp-003.plus.net [84.93.230.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0091D7995
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 04:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772772063; cv=none; b=Fj5dbB/cGWi13v9+ItrKl58Y1lnkNahjqK+yDEYdHe4MfUeTfxvnpz4FI5MXU23MeiKhqQeF6ENocsqdrtdOU8bc9L46ATbZ3Rrm7g9x6W2R8tDGSYHHbZuOlEnf+Mp72mIuruRkQiFm9vptqxukbOW5QWvTbaW7MGmNTiM3BXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772772063; c=relaxed/simple;
	bh=L7hCBH2noj/CTnWEW5Jx/euDjeb/aCtwT3guXzt5yeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5be81uc1kg1iU120kHDd9MyFaIhNrZH2rE9NQWyChkOvY9evI8B6AmnYhvhSkMogZjqdnTR/6XtvezbW4sBCa24AUeDVnnq3QyqNIQHQBOOn+O6cpvIVGDP3NAavWQ9aLtLkq3nbompedJ+80QWl3Ka+UDP12xmxDAlBdqcTc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com; spf=pass smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=Zu4xcZYt; arc=none smtp.client-ip=84.93.230.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="Zu4xcZYt"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id yMwfv9MwM4vCcyMwgvCq2E; Fri, 06 Mar 2026 04:37:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1772771871; bh=FGEmZdkvp8cFFAMXDP749ZpGqBlohH3zITzYVy1rF5I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Zu4xcZYtb8nbovkfg4srvcODK81rFqb4Af7e/d5e0QNsxRfRXDpi3MwVSECS99lDq
	 iGNuRwPL+l9GE5jskvIpwfA06i8q3PH8owiFoQmD9IjEYUpXouL1cQVjL+rTj8bDdm
	 wQBXBFoNmzy1HWyPrVkpoCDdlq1kfb2VgzzT6qIl7fSdynhe8pnoGqcWaEAujQhnCM
	 V5ypZgYHbsl7QZi98pnieC1chPtIiyh6HspgcocKOPD3WWCDV8lCOLeS+wGi6GmQfk
	 /gAOayM8HFkWoZQqeZhJQgZqUrAIx1j21HtnpjoBq87tqKSjjkAx9dvUIaGMEg4ZMI
	 RIYkkZa02y4kg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=KZZxshYD c=1 sm=1 tr=0 ts=69aa5a1f
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=U7UbAiMzAAAA:8 a=EBOSESyhAAAA:8 a=33HjggFcLjaVow7NPeEA:9
 a=QEXdDO2ut3YA:10 a=cNtvukwP7kaFzDVqf0Q5:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <9137fd66-9ac3-42ff-a892-1b6f20b49972@ramsayjones.plus.com>
Date: Fri, 6 Mar 2026 04:37:49 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] plugging some mmap() leaks
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
References: <b9fa930e-7d5e-47f1-8896-1997cf7c0cdb@intel.com>
 <20260305220214.GB736322@coredump.intra.peff.net>
 <20260305230315.GA2354983@coredump.intra.peff.net>
Content-Language: en-US
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <20260305230315.GA2354983@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfF/U7p4IsUDkFcXT6MMBOFJ3Nf9kiVb4rlCpYFRX3FliTjbVBeA4p3Dhqt3JIskaiAz17E4HblcPIedHWeNCpiwISgMSywlZxvCgo//GbeLbIODS7D4J
 vbK+87xnmAnuZFLY6Xf5bOfPv5gaXRAvcbkHSI80JvNYGcaO/92KNvzNvTkEFg/FX2bEPUPtlOtLaq6TTiLohaeB+gARDWmRzGc=



On 05/03/2026 11:03 pm, Jeff King wrote:
> On Thu, Mar 05, 2026 at 05:02:14PM -0500, Jeff King wrote:
> 
>> Anyway, I think the solution is probably something like the patch above,
>> though probably it needs to cover the case where new_pack is NULL.
> 
> So here is a more polished version. I decided to try running the whole
> test suite with leak-checking and NO_MMAP, and it turned up one other
> case. This series fixes that, too, and then turns on the flag for all
> leak-checking builds.
> 

Hmm, this gives me flash-backs. ;)

Many moons ago, when the cygwin build routinely set NO_MMAP I had an
valgrind build of git fail with a 'double free' caused by a call to
git_munmap() for a pointer that had already been git_munmap-ed!

In addition, the failure was not reproducible (or at least I could not
find such a test). This was at a time when the testsuite took 4+ hours
to run for a regular build, let alone a valgrind build. So, to try and
pin down the failure, I created a debug version of the mmap compat
functions, which I ran with for several weeks, without failing ... :(

It just so happens that about this time I was also testing running the
cygwin build without NO_MMAP set. This was a success, so I dropped
the NO_MMAP investigation, never having found the cause of the failure!

I have had the 'mmap' branch, with a version of the debug patch, in my
cygwin repo for ever (well, the 'author date' says sep 9th 2012, but I
know it was somewhat before then). This version of the patch removed the
'debug' output and was only concerned with the error return behaviour of
the 'emulated' syscalls. (it was also somewhat non-performant if you had
many mmap's; luckily, that wasn't the case then, and I tended to git-gc
very often - which I still do to this day!)

Anyway, just some food for thought. I have nearly deleted that branch
many times. I should probably do that now! (Hmm, patch given below just
FYI).

Thanks.

ATB,
Ramsay Jones

-------- >8 --------
From 40442aa06901720ec55005144438c8c733025cbb Mon Sep 17 00:00:00 2001
From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Date: Sun, 9 Sep 2012 20:50:32 +0100
Subject: [PATCH] mmap.c: log mmap() blocks to avoid double-delete bug

When compiling with the NO_MMAP build variable set, the built-in
'git_mmap()' and 'git_munmap()' compatability routines use simple
memory allocation and file I/O to emulate the required behaviour.
The current implementation is vunerable to the "double-delete" bug
(where the pointer returned by malloc() is passed to free() two or
more times), should the mapped memory block address be passed to
munmap() multiple times.

In order to guard the implementation from such a calling sequence,
we keep a list of mmap-block descriptors, which we then consult to
determine the validity of the input pointer to munmap(). This then
allows 'git_munmap()' to return -1 on error, as required, with
errno set to EINVAL.

Using a list in the log of mmap-ed blocks, along with the resulting
linear search, means that the performance of the code is directly
proportional to the number of concurrently active memory mapped
file regions. The number of such regions is not expected to be
excessive.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 compat/mmap.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/compat/mmap.c b/compat/mmap.c
index 7f662fef7b..137c6dc005 100644
--- a/compat/mmap.c
+++ b/compat/mmap.c
@@ -1,14 +1,61 @@
 #include "../git-compat-util.h"
 
+struct mmbd {  /* memory mapped block descriptor */
+	struct mmbd *next;  /* next in list */
+	void   *start;      /* pointer to memory mapped block */
+	size_t length;      /* length of memory mapped block */
+};
+
+static struct mmbd *head;  /* head of mmb descriptor list */
+
+
+static void add_desc(struct mmbd *desc, void *start, size_t length)
+{
+	desc->start = start;
+	desc->length = length;
+	desc->next = head;
+	head = desc;
+}
+
+static void free_desc(struct mmbd *desc)
+{
+	if (head == desc)
+		head = head->next;
+	else {
+		struct mmbd *d = head;
+		for (; d; d = d->next) {
+			if (d->next == desc) {
+				d->next = desc->next;
+				break;
+			}
+		}
+	}
+	free(desc);
+}
+
+static struct mmbd *find_desc(void *start)
+{
+	struct mmbd *d = head;
+	for (; d; d = d->next) {
+		if (d->start == start)
+			return d;
+	}
+	return NULL;
+}
+
 void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t offset)
 {
 	size_t n = 0;
+	struct mmbd *desc = NULL;
 
 	if (start != NULL || !(flags & MAP_PRIVATE))
 		die("Invalid usage of mmap when built with NO_MMAP");
 
 	start = xmalloc(length);
-	if (start == NULL) {
+	desc = xmalloc(sizeof(*desc));
+	if (!start || !desc) {
+		free(start);
+		free(desc);
 		errno = ENOMEM;
 		return MAP_FAILED;
 	}
@@ -23,18 +70,26 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
 
 		if (count < 0) {
 			free(start);
+			free(desc);
 			errno = EACCES;
 			return MAP_FAILED;
 		}
 
 		n += count;
 	}
+	add_desc(desc, start, length);
 
 	return start;
 }
 
 int git_munmap(void *start, size_t length)
 {
+	struct mmbd *d = find_desc(start);
+	if (!d) {
+		errno = EINVAL;
+		return -1;
+	}
+	free_desc(d);
 	free(start);
 	return 0;
 }
-- 
2.53.0


