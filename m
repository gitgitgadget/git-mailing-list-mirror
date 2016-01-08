From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 15/16] refs: add LMDB refs backend
Date: Fri, 08 Jan 2016 11:05:53 -0500
Organization: Twitter
Message-ID: <1452269153.24133.14.camel@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	 <1449102921-7707-16-git-send-email-dturner@twopensource.com>
	 <567AB07E.1010803@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Michael Haggerty <mhagger@alum.mit.edu>,
	git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 08 17:06:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHZY9-0001xv-4S
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 17:06:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755828AbcAHQF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 11:05:57 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:34800 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755649AbcAHQFz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 11:05:55 -0500
Received: by mail-qg0-f43.google.com with SMTP id 6so276904231qgy.1
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 08:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=SL+5AhY4NBadi8bdi7wdrvTZ7TD1NEtwHcrLoH+Tx4o=;
        b=cqbDjfUnBGAC5Y/3HfkshM9tOyXdTqG8AUqtT52FAVpN16xPwN2cAWzZ7W6ni2ucb+
         dIlbO5uDaRhARHkGqR00g9dZzVXkKbHPov7fuGa+cTcftfc2RkCOxOoDB2/GtKpEscSr
         UjLj4ud16zaSg35gwqTwTruE9jbG1hleZNNrytYZIMOTNtggQfhzoouCYDKXFUZ1UGDX
         fBkImyyTEmCdSzdKwOBU+8NsrNcVTjcxIhcBjb/u5qNGxLZaKLexGIDzI7oHed9uqmQ3
         NeWl7Y7lxEcw+roo4Dln3OyxQ6kxqDT3Phs84fmd4lqttjojBzUEBAfjVArtZpa1TUEQ
         TZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=SL+5AhY4NBadi8bdi7wdrvTZ7TD1NEtwHcrLoH+Tx4o=;
        b=O1R1XGxP7z5GroLOdm1FFQWBZBJxi2kDx3xpKdoDUF5j5NM4Fe5h+f/wREodXwhRyq
         ME1JsoqNRlNquUp4EXXBJAjDvkJO0Rr8qkv+kWp8S0amCtTTzHupHFO9OngvU44kg0st
         1yXHj+h9m05lzeUfdK9kCS8KogCYK2E/oDX7r+cQlTA1ZiK6FPFDqMUWMjnv58bax/EJ
         RaUo/lhY6cA7NuL7QIEHhSWd78XOAtqCHT64su4fNqu47Io3VitDpEaFm4NIwDN1wmmy
         gCg4UslCOG8JDzkI0CbJnq1SwHs9Lx8O9REoJb5GxgVo5q1rmHx3rzZP+xvnvQHINPpA
         niNA==
X-Gm-Message-State: ALoCoQlxijjgAppOA8qgtS8qf/yFoYheRs9aqV4Wsd6FxqxzuWrzme2P8/N4KLw4g5ho9axoukTqzYMRcw9qhNNA4z3B8bjByQ==
X-Received: by 10.140.172.84 with SMTP id s81mr146304080qhs.40.1452269154916;
        Fri, 08 Jan 2016 08:05:54 -0800 (PST)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id 9sm32087501qgf.38.2016.01.08.08.05.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Jan 2016 08:05:54 -0800 (PST)
In-Reply-To: <567AB07E.1010803@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283559>

On Wed, 2015-12-23 at 15:32 +0100, Michael Haggerty wrote:
> +core.refsBackendType::
> > +	Type of refs backend. Default is to use the original files
> > +	based backend. Set to 'lmdb' to activate the lmdb database
> > +	backend.  If you use the lmdb backend,
> > +	core.repositoryFormatVersion must be set to 1, and
> > +	extensions.refBackend must be set to 'lmdb'.
> 
> This phrasing makes it sound like I can go into an existing
> repository,
> change this repository setting, and *presto* I will have a LMDB
> -backed
> repository. I suggest rewording it more along the lines of "this
> setting
> reflects the refs backend that is currently in use".
> 
> Also please see my earlier question about whether users should see
> the
> term "backend" or whether other terms would be easier to understand.

Adjusted, thanks.

> > +All per-worktree refs (refs/bisect/* and HEAD) are store using
> 
> s/store/stored/

Fixed.

> > +the traditional files-based backend.
> > +
> > +Reflogs are stored as a series of database entries.
> > +
> > +For non-empty reflogs, there is one entry per logged ref
> > +update.  The key format is logs/[refname]\0[timestamp].  The
> > timestamp
> > +is a 64-bit unsigned integer number of nanoseconds since 1/1/1970.
> > +This means that reflog entries are chronologically ordered. 
> >  Because
> > +LMDB is a btree database, we can efficiently iterate over these
> > keys.
> 
> Is there a guarantee that the reflog entries for all references
> updated
> in a single transaction have the same timestamp? Is there a guarantee
> that updates that happened in *different* transactions have different
> timestamps? These might be useful properties if they are easy to
> implement, because then one could deduce the scope of transactions
> from
> the reflog. But of course, they admittedly go beyond what the files
> backend offers and so are not a requirement.

All of this stuff is handled outside of the storage backend, so I don't
want to address it here.  That is, this offers the same guarantees as
the files-based backend (neither of those, I think).

> Is the timestamp in ASCII base 10, binary format, or or something
> else?

I've added the words "network byte order" to make it clear that this is
binary.

> > +For an empty reflog, there is a "header" entry to show that a
> > reflog
> > +exists.  The header has the same format as an ordinary reflog, but
> > with
> > +a timeztamp of all zeros and an empty value.
> > +
> > +Reflog values are in the same format as the original files-based
> > +reflog.
> 
> I assume that means that each entry has the same contents as one line
> from a reflog file. Does the value include a trailing LF? (From above
> I
> guess it does have a trailing NUL.)

Trailing LF, yes; will fix.

> Is the timestamp within the reflog entry guaranteed to agree with the
> timestamp in the key? This might be a convenient property for
> debugging.

Yes; edited.
diff --git a/Makefile b/Makefile

> > index 5bd68e0..77b96d9 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1037,6 +1037,17 @@ ifdef USE_LIBPCRE
> >  	EXTLIBS += -lpcre
> >  endif
> >  
> > +ifdef USE_LIBLMDB
> > +	BASIC_CFLAGS += -DUSE_LIBLMDB
> > +	ifdef LIBLMDBDIR
> > +		BASIC_CFLAGS += -I$(LIBLMDBDIR)/include
> > +		EXTLIBS += -L$(LIBLMDBDIR)/$(lib)
> > $(CC_LD_DYNPATH)$(LIBLMDBDIR)/$(lib)
> > +	endif
> > +	EXTLIBS += -llmdb
> > +	LIB_OBJS += refs/lmdb-backend.o
> > +	TEST_PROGRAMS_NEED_X += test-refs-lmdb-backend
> > +endif
> > +
> >  ifdef HAVE_ALLOCA_H
> >  	BASIC_CFLAGS += -DHAVE_ALLOCA_H
> >  endif
> > @@ -2124,6 +2135,7 @@ GIT-BUILD-OPTIONS: FORCE
> >  	@echo NO_CURL=\''$(subst ','\'',$(subst
> > ','\'',$(NO_CURL)))'\' >>$@+
> >  	@echo NO_EXPAT=\''$(subst ','\'',$(subst
> > ','\'',$(NO_EXPAT)))'\' >>$@+
> >  	@echo USE_LIBPCRE=\''$(subst ','\'',$(subst
> > ','\'',$(USE_LIBPCRE)))'\' >>$@+
> > +	@echo USE_LIBLMDB=\''$(subst ','\'',$(subst
> > ','\'',$(USE_LIBLMDB)))'\' >>$@+
> >  	@echo NO_PERL=\''$(subst ','\'',$(subst
> > ','\'',$(NO_PERL)))'\' >>$@+
> >  	@echo NO_PYTHON=\''$(subst ','\'',$(subst
> > ','\'',$(NO_PYTHON)))'\' >>$@+
> >  	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst
> > ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
> > diff --git a/builtin/init-db.c b/builtin/init-db.c
> > index 44db591..1eb2feb 100644
> > --- a/builtin/init-db.c
> > +++ b/builtin/init-db.c
> > @@ -179,6 +179,7 @@ static int create_default_files(const char
> > *template_path)
> >  	int reinit;
> >  	int filemode;
> >  	struct strbuf err = STRBUF_INIT;
> > +	int repo_version = 0;
> >  
> >  	/* Just look for `init.templatedir` */
> >  	git_config(git_init_db_config, NULL);
> > @@ -209,7 +210,14 @@ static int create_default_files(const char
> > *template_path)
> >  		git_config_set("core.refsBackendType",
> > refs_backend_type);
> >  		config_data.refs_backend_type = refs_backend_type;
> >  		config_data.refs_base = get_git_dir();
> > +#ifdef USE_LIBLMDB
> > +		register_refs_backend(&refs_be_lmdb);
> > +#endif
> >  		set_refs_backend(refs_backend_type, &config_data);
> > +		if (!strcmp(refs_backend_type, "lmdb")) {
> 
> Wouldn't expressing this condition as
> 
>     if (strcmp(refs_backend_type, "files"))
> 
> better reflect the reason that we might need to set
> "extensions.refBackend" and use repo_version "1"?

Yeah.

>  (You might also need a
> "refs_backend_type &&" and/or a "*refs_backend_type &&" in there.)

I've just decided to set this var to be "files" by default, to simplify
a lot of this code.

> >   *  - either an objects/ directory _or_ the proper
> >   *    GIT_OBJECT_DIRECTORY environment variable
> > - *  - a refs/ directory
> > - *  - either a HEAD symlink or a HEAD file that is formatted as
> > - *    a proper "ref:", or a regular file HEAD that has a properly
> > - *    formatted sha1 object name.
> > + *  - a refdb/ directory or
> > + *    - a refs/ directory
> > + *    - either a HEAD symlink or a HEAD file that is formatted as
> > + *      a proper "ref:", or a regular file HEAD that has a
> > properly
> > + *      formatted sha1 object name.
> 
> The indentation looks wrong here. I think the requirement is
> *  - either a refdb/ directory or a refs/ directory
> *  - either a HEAD symlink or a HEAD file that is formatted as
> *    a proper "ref:", or a regular file HEAD that has a properly
> *    formatted sha1 object name.
> 
> though the test of the *contents* of HEAD is currently skipped for
> non-files backends.

Yes.

Thanks for the review. Hopefully another version by EOD, but we'll see.
