Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7753EB11B
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 09:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922142; cv=none; b=Is5HrpLqMX61EKA2yLJ/UPnri4TSquhPK/cjcbK0/Q8uOVBtA0FrADjiTr9RnEAkR6yPhyqRwyTpq6YJkvUTB2srW+XqxhncJHCfza/5aI8ZxN7+IS7orxkgJQdcdMrpIPY188PT4Z2AzuBxBiMPk0cL2air6mgWSxDsURDYPbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922142; c=relaxed/simple;
	bh=+yHR0axUJmUhOHlnBfU0MjD3KoyEFD/lrTlEgWvzOes=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=GdigLfG1wRGhbBt4eWUb66M6nGhcK0a1ZbO/8NFh5NY4/egzH7+FQpWKZ7GVmKBhXEAJk3TfZbkMWifsQBMmOjwsJOuDljj6Q1aDJPalbk8TFf6GTBTpZI0eDCCA8GMkOfUxwjtf1twIZVwxUJZwViEp3Q6Jf3NDnpHTl0W4PFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mmaux8vf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DuCuYZf5; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mmaux8vf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DuCuYZf5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B22731400157;
	Wed,  5 Aug 2026 05:28:59 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 05 Aug 2026 05:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785922139;
	 x=1786008539; bh=l8kUlpsUXxkidqIemjM6hN39jjsWGchRU1ktqXIaFpw=; b=
	mmaux8vfe5aFSk+OR2x5F+sXZ4G/ZvSirGbFDNh9iGTme0ueMmT/sf1yqCutq2BL
	RnIr1Ik6/w+YSfdsMbTkDgwXnzb8cGwiZH5EufzdXpJOISs0ELnaA0A7OeA+OPTR
	pY2j+KH/fEvqHjlbgF2OjljayIM2+WoKT856KN8xR96tVxMzNBoHKBTetx8UrH03
	RoZ9Tqc3sCB20PX2cNgdrVmVWkSJPnlW9ikb1tICHu3cn1NAoOUvfhRj9WRnGeDx
	9cPgU/Arf7vFCGGImzTzg2vYpCPFMgA/Znfx0uN1bulEbkBOCMWluFQ7McMrfS9b
	ZmjfNjATcO7jtaJ0y2djHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1785922139; x=
	1786008539; bh=l8kUlpsUXxkidqIemjM6hN39jjsWGchRU1ktqXIaFpw=; b=D
	uCuYZf53Tp28M9NTQdAzvT8vlEz8gIRmTWkQ8YC5IHtGyAbJofgoWnLFd5xo4pp/
	BugddoYVpjZV/EXxJC6u5jUkEZ/zPNOKoib/Vzy3A0WHnWYyP0vJFD50C5tAHvDb
	7vXT1b/g0Yq79fV2ij2wO7/Ot2fnCmeSH/IzJen5pQYJM77PNhFVfwKZmB4jE5RR
	O30PGTTOgHX3rJoPeqOxqGorZ1I8WCN0/P8unt1dF1ygrFnSsmeKMyYu0i468c56
	mQmQon/ATDiKtVEKfWL5SuUSDNnm7+KhbaV8CtTAWlNIyBGTyMmy+bKMA5ieopiR
	OQWOs5jhqpnHm6pyaI36Q==
X-ME-Sender: <xms:WgJzagtZvbn9z8_fUoAztKnr8KCHfLavMH646NosOAV6fC1qg8YRBw>
    <xme:WgJzakeM8TYwNFEyanZJ6y2D4F5q6rrn6xV72gCJKBsr8712I55B8s4QZt9SkhMRM
    pUv0kh-eeB0xBYJ5pMPMZO7sgz2N5JYucR0CSJ61jokprsSHIJHCg>
X-ME-Received: <xmr:WgJzagySPrrvkVYAZBVcZ033xHPuzRF_p3n65O29dxFyYJGeTiKYZ5G4pxiJcearLGzEWx2o4fc07ZtDCzFkg9q0Gddhg5GpAxV4Mqh15w>
X-ME-Proxy-Cause: dmFkZTGKZxN1HxcQN2qYwuVOqpSRTPnE8sc7TLnykaEpPxel6QnWesV4ndmpvrK6Cbtlbu
    SbhGZhZ29XK8N+LHwh895Qzkm3KiH6cg1Bfbre6u0sJx1T0cM3ADRO8CAQLWG4P150tWFX
    jMwyRfNPTFIzE/KlcvSgMrdeOS1Wwak3lyYzNHFnICYnna6b3vvZvC3vYmqfvawnfBOByJ
    waY748pGY5SRCC9/hkLfv+G8aLeipZnTSzXUqXAQfnfZyMpO1tYJv5f9q34STydMzsMUb7
    x8f08+Z4JZFIrewCe+T8tT2vDNdyJryVfBKRrA67xzTt9VmWgA/BUQMz9jNFqux0Nj36ej
    BgcnOy4h4wibqem61EfRt9M9jctHmsV3jf/Rl9/uZzAtJnlfwAQc2DZilmFwfSHTCA7nrD
    BBNrqabopy9Y47q03f+FyJgpUxNbESDRd8obNBgn2ifchfT0qjhT0YB8CseK9yvNJKxohP
    wn4IsjpQ4vO1lr/LIKgqXZ6QcmhBVrtkE31AtcbGEZRGwzV83AZax7nomnrTZNsuGA4CvQ
    mK6VCKNyS8pWFn2znXJQmZlN6/J27IN0uCTeM2LtQQ2/pwuxKV7iQZ7Ktx2aem7ZzBwq0S
    kykxB8PcsHdnJ60o8OFg9fiAtWe8YDbQTSOenQxHT+VvnZEAird2fj0FwE3g
X-ME-Proxy: <xmx:WgJzaiEFC2gRZaO6Ll9aADUk4Qb0tupPN7es6RiKvE2RBIj01s17Fw>
    <xmx:WgJzaswK-jh1VR2au1GzL1zvdVGeREaPr3tz8vMnek6ds-jW9TzA-Q>
    <xmx:WgJzarsu0BI8R8Lcb3JrMX5J4rwJ4yWGaB1Dex0H26AFpuM-Ql1bWg>
    <xmx:WgJzah377tLUNu4kfkpAKnDBIqlD2IMdPBCYaLMwKFxXV1a7WSiupg>
    <xmx:WwJzagwyX7ZPTEls11c94anlsmd9fgTQAFNJW7jp9lNXaLzE86_aV_zg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Aug 2026 05:28:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 21b2b912 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 5 Aug 2026 09:28:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/6] odb: make creation of object database pluggable
Date: Wed, 05 Aug 2026 11:28:50 +0200
Message-Id: <20260805-pks-odb-create-on-disk-v3-0-c0ee3ac5141f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ6CMBAFf4X07Jq2CC2e/A/jgdJFViIlLRIN4
 d8taPTE8SXzZiYW0BMGdkwm5nGkQK6LI90lrGrK7opANm4mucy5Ehz6NoCzBiqP5YDgOrAUWih
 Rq0zpXFR5weK591jTcxWfL58dHuaG1bDYFqKhMDj/WsujWLhvRB62IqMADqlJrcwzW6jCnCK4p
 ztbCqP8OzTfdsjosLbWJiuMlVz9HPM8vwF5VSdSDwEAAA==
X-Change-ID: 20260710-pks-odb-create-on-disk-ae8757861c69
In-Reply-To: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

Hi,

when creating a new repository we create a couple of on-disk data
structures for the object database. This includes the "objects/"
directory hierarchy with "objects/info" and "objects/pack", which are
specific to the backend.

This patch series makes the creation of the on-disk data structures
pluggable. While we continue to always create "objects/" regardless of
the backend (it's required for a repository to be recognized as such),
the other subdirectories are now created by the backend. This will allow
other backends to plug in their own logic.

The series starts with a small detour into the loose-object map. This
detour is required so that we can defer initialization of the object
database itself to a later point in time.

The series is based on 9a0c4701dc (The 7th batch, 2026-07-22).

Changes in v3:
  - Move handling of GIT_OBJECT_DIRECTORY and
    GIT_ALTERNATE_OBJECT_DIRECTORIES into `odb_new()` itself. This
    deduplicates some of the logic and also preps us for a future where
    alternates are handled in the "files" backend itself.
  - Link to v2: https://patch.msgid.link/20260804-pks-odb-create-on-disk-v2-0-ddf8b59bd207@pks.im

Changes in v2:
  - Add a testcase that demonstrates the bug fixed with alternate loose
    object maps.
  - Rename the "inmemory" bakcend to "in-memory".
  - Clarify some commit messages.
  - Link to v1: https://patch.msgid.link/20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (6):
      loose: load loose object map for the correct source
      setup: detangle loading of loose object maps
      setup: handle ODB-related environment variables in `odb_new()`
      setup: defer object database creation
      odb/source: introduce function to map source type to name
      odb: make creation of on-disk structures pluggable

 loose.c                       | 25 +++++++++---------
 loose.h                       |  1 +
 odb.c                         | 20 +++++++++------
 odb.h                         | 17 ++++++++++--
 odb/source-files.c            | 19 ++++++++++++++
 odb/source-files.h            |  4 ++-
 odb/source-inmemory.h         |  4 ++-
 odb/source-loose.c            |  2 ++
 odb/source-loose.h            |  4 ++-
 odb/source-packed.h           |  4 ++-
 odb/source.c                  | 19 ++++++++++++++
 odb/source.h                  | 29 +++++++++++++++++++++
 repository.c                  |  2 --
 setup.c                       | 60 ++++++++++++++++++++++++-------------------
 setup.h                       |  9 +++++++
 t/t1016-compatObjectFormat.sh | 18 +++++++++++++
 t/unit-tests/u-odb-inmemory.c |  2 +-
 17 files changed, 183 insertions(+), 56 deletions(-)

Range-diff versus v2:

1:  b0beb61a74 = 1:  d384dd0635 loose: load loose object map for the correct source
2:  097bdcad14 = 2:  0ee1b3c032 setup: detangle loading of loose object maps
-:  ---------- > 3:  f52992b9bd setup: handle ODB-related environment variables in `odb_new()`
3:  06645224ef ! 4:  4524fc5ec4 setup: defer object database creation
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## setup.c ##
    -@@ setup.c: enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
    - 	return result;
    - }
    - 
    -+static void get_object_directories(char **object_directory,
    -+				   char **alternate_object_directories)
    -+{
    -+	*object_directory = xstrdup_or_null(getenv(DB_ENVIRONMENT));
    -+	*alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
    -+}
    -+
    - int apply_repository_format(struct repository *repo,
    - 			    const struct repository_format *format,
    - 			    enum apply_repository_format_flags flags,
     @@ setup.c: int apply_repository_format(struct repository *repo,
    - 	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV) {
    - 		const char *shallow_file;
    + 			    enum apply_repository_format_flags flags,
    + 			    struct strbuf *err)
    + {
    +-	enum odb_new_flags odb_new_flags = 0;
    +-
    + 	if (verify_repository_format(format, err) < 0)
    + 		return -1;
      
    --		object_directory = xstrdup_or_null(getenv(DB_ENVIRONMENT));
    --		alternate_object_directories = xstrdup_or_null(getenv(ALTERNATE_DB_ENVIRONMENT));
    -+		get_object_directories(&object_directory,
    -+				       &alternate_object_directories);
    -+
    - 		shallow_file = getenv(GIT_SHALLOW_FILE_ENVIRONMENT);
    - 		if (shallow_file)
    - 			set_alternate_shallow_file(repo, shallow_file);
     @@ setup.c: int apply_repository_format(struct repository *repo,
      	repo->repository_format_precious_objects =
      		format->precious_objects;
      
    --	repo->objects = odb_new(repo, object_directory,
    --				alternate_object_directories);
    -+	if (!(flags & APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION))
    -+		repo->objects = odb_new(repo, object_directory,
    -+					alternate_object_directories);
    +-	if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV)
    +-		odb_new_flags |= ODB_NEW_HONOR_ENV;
    +-	repo->objects = odb_new(repo, odb_new_flags);
    ++	if (!(flags & APPLY_REPOSITORY_FORMAT_SKIP_ODB_CREATION)) {
    ++		enum odb_new_flags odb_new_flags = 0;
    ++		if (flags & APPLY_REPOSITORY_FORMAT_HONOR_ENV)
    ++			odb_new_flags |= ODB_NEW_HONOR_ENV;
    ++		repo->objects = odb_new(repo, odb_new_flags);
    ++	}
      
    - 	free(alternate_object_directories);
    - 	free(object_directory);
    + 	return 0;
    + }
     @@ setup.c: static int create_default_files(struct repository *repo,
      	return reinit;
      }
    @@ setup.c: static int create_default_files(struct repository *repo,
     -static void create_object_directory(struct repository *repo)
     +static void create_object_database(struct repository *repo)
      {
    -+	char *object_directory, *alternate_object_directories;
      	struct strbuf path = STRBUF_INIT;
      	size_t baselen;
      
    -+	get_object_directories(&object_directory, &alternate_object_directories);
    -+	repo->objects = odb_new(repo, object_directory,
    -+				alternate_object_directories);
    ++	repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
     +
      	strbuf_addstr(&path, repo_get_object_directory(repo));
      	baselen = path.len;
      
    -@@ setup.c: static void create_object_directory(struct repository *repo)
    - 	strbuf_addstr(&path, "/info");
    - 	safe_create_dir(repo, path.buf, 1);
    - 
    -+	free(alternate_object_directories);
    -+	free(object_directory);
    - 	strbuf_release(&path);
    - }
    - 
     @@ setup.c: int init_db(struct repository *repo,
      	 */
      	read_and_verify_repository_format(&repo_fmt, repo_get_git_dir(repo), NULL);
4:  46ad0386bb = 5:  c526fd526b odb/source: introduce function to map source type to name
5:  3063325cf9 ! 6:  d752e48eba odb: make creation of on-disk structures pluggable
    @@ odb/source.h: static inline void odb_source_close(struct odb_source *source)
     
      ## setup.c ##
     @@ setup.c: static int create_default_files(struct repository *repo,
    + 
      static void create_object_database(struct repository *repo)
      {
    - 	char *object_directory, *alternate_object_directories;
     -	struct strbuf path = STRBUF_INIT;
     -	size_t baselen;
    - 
    - 	get_object_directories(&object_directory, &alternate_object_directories);
    --	repo->objects = odb_new(repo, object_directory,
    --				alternate_object_directories);
    - 
    --	strbuf_addstr(&path, repo_get_object_directory(repo));
    --	baselen = path.len;
    --
    --	safe_create_dir(repo, path.buf, 1);
     +	/*
     +	 * Create the "objects" directory in the common directory. This is done
     +	 * so that the repository can be discovered regardless of the backend
    @@ setup.c: static int create_default_files(struct repository *repo,
     +	 * then we skip this step, as the repository won't be discoverable
     +	 * anyway without the environment variable.
     +	 */
    -+	if (!object_directory) {
    ++	if (!getenv(DB_ENVIRONMENT)) {
     +		struct strbuf objects_dir = STRBUF_INIT;
     +		repo_common_path_append(repo, &objects_dir, "objects");
     +		safe_create_dir(repo, objects_dir.buf, 1);
     +		strbuf_release(&objects_dir);
     +	}
      
    + 	repo->objects = odb_new(repo, ODB_NEW_HONOR_ENV);
    + 
    +-	strbuf_addstr(&path, repo_get_object_directory(repo));
    +-	baselen = path.len;
    +-
    +-	safe_create_dir(repo, path.buf, 1);
    +-
     -	strbuf_setlen(&path, baselen);
     -	strbuf_addstr(&path, "/pack");
     -	safe_create_dir(repo, path.buf, 1);
    -+	repo->objects = odb_new(repo, object_directory,
    -+				alternate_object_directories);
    - 
    +-
     -	strbuf_setlen(&path, baselen);
     -	strbuf_addstr(&path, "/info");
     -	safe_create_dir(repo, path.buf, 1);
    +-
    +-	strbuf_release(&path);
     +	if (odb_source_create_on_disk(repo->objects->sources) < 0)
     +		die("failed creating object database");
    - 
    - 	free(alternate_object_directories);
    - 	free(object_directory);
    --	strbuf_release(&path);
      }
      
      static void separate_git_dir(const char *git_dir, const char *git_link)

---
base-commit: 9a0c4701dcd5725c4184599322b52933ff5005ca
change-id: 20260710-pks-odb-create-on-disk-ae8757861c69

