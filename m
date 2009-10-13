From: Imran M Yousuf <imyousuf@gmail.com>
Subject: Re: [JGit-io-RFC-PATCH v2 2/4] Add JGit IO SPI and default 
	implementation
Date: Tue, 13 Oct 2009 22:59:49 +0700
Message-ID: <7bfdc29a0910130859w537f07efy5d5922c45e6ad39d@mail.gmail.com>
References: <1255270073-14205-1-git-send-email-imyousuf@gmail.com>
	 <1255270073-14205-2-git-send-email-imyousuf@gmail.com>
	 <20091012145741.GM9261@spearce.org>
	 <7bfdc29a0910121830y4dc9b3efpe17860e04457988d@mail.gmail.com>
	 <20091013151522.GR9261@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, egit-dev@eclipse.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 18:05:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxjrz-0002Rl-UE
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 18:05:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933848AbZJMQA3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Oct 2009 12:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760426AbZJMQA3
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 12:00:29 -0400
Received: from mail-vw0-f203.google.com ([209.85.212.203]:60743 "EHLO
	mail-vw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760404AbZJMQA1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Oct 2009 12:00:27 -0400
Received: by vws41 with SMTP id 41so5314732vws.4
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 08:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0LttPe525kXq5R0Cw+6qqm/aGvh97Sc42uci2N9K2Ps=;
        b=D6JunTCLSmSaoHrsKKWMZSTSjq65aii+LI5YiDi5YxgI142oOQpVAtZe/0PzGkq5UD
         kW0VVlMASA35dWOT2orzK5RUmSvYEd2l2id7/ZL0Gew+ET0cyMvhneTB2DryFmIkbBfg
         UHqF68JhZmMdc+f4fKI0Q3QWKJUluhPFGt4lA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tE8OiPEo2WPgPAXXNvYEiA1kGi5gUGuMitjRvvB1A+6wFpm9k4kOxp2gpAD5saXu6F
         1NHtY2RWdQHPlQr1plq9YLEeUUlICWrvnSG1X6214U8p8ySAkPkI4pVDdFlm7Kx6WigB
         s7CezKj+HyE6kzYQ2GGq3+zmHdZR1wtkr/rwE=
Received: by 10.220.88.23 with SMTP id y23mr10645140vcl.94.1255449589383; Tue, 
	13 Oct 2009 08:59:49 -0700 (PDT)
In-Reply-To: <20091013151522.GR9261@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130168>

Hi Shawn,

=46irstly thanks for the reply, my comments are inline.

On Tue, Oct 13, 2009 at 10:15 PM, Shawn O. Pearce <spearce@spearce.org>=
 wrote:
> Imran M Yousuf <imyousuf@gmail.com> wrote:
>> Firstly, I am sorry but I am not intelligent enough to perceive, how
>> do the user decide which instance of Config to use? I personally thi=
nk
>> that there is no API to achieve what you just mentioned :(; i.e. the
>> user will have know CassandraConfig directly.
>
> Yes. =A0Well, almost.
>
> The user will have to know that s/he wants a CassandraRepository or
> a JdbcRepository in order to obtain the abstract Repository handle.
> Each of these will need different configuration, possibly data which
> is too complex to simply cram into a URL string, so I was expecting
> the application would construct the concrete Repository class and
> configure it with the proper arguments required for contact with
> the underlying storage.
>
> Since the Repository wants several things associated with it, each
> concrete Repository class knows what concrete Config, ObjectDatabase
> and RefDatabase it should create. =A0Those concrete classes know how
> to read a repository stored on that medium.
>

Hmm, when trying to come up with an API, where I essentially wanted a
to abstract all records, I noticed that everything uses java.io.File
and I never actually thought in this line.

Well, I was thinking of in terms of URI as I think Git and in turn
JGit (some how feels so) follows REST and from my understanding of git
storage (which very well could be incorrect) URI could be a perfect
match. Question of how a implementation requiring configuration be fed
to the SPI manager is simple before JGit is used the instance it self
is registered to the manager. So e.g. for JDBC the URI could very well
look like - jdbc://etc/X11/ for a repo path and the JDBC implementor
will already know the connection config specs etc. so there is no need
to cramp in all info in the URL.

>> Secondly, I instead was
>> thinking of porting JGit for that matter to any system supporting
>> streams (not any specific sub-class of them), such HBase/BigTable or
>> HDFS anything.... Thirdly, I think we actually have several task in
>> hand and I would state them as -
>>
>> 1. First introduce the I/O API such that it completely replaces java=
=2Eio.File
>> 2. Secondly segregate persistence of for config (or config like
>> objects) and introduce a SPI for them for smarter storage.
>
> Supporting streams on an arbitrary backend is difficult. =A0DHTs like
> BigTable/Cassandra aren't very good at providing streams, they tend
> to have a limit on how big a row can be. =A0They tend to have very
> slow read latencies, but can return a small block of consecutive
> rows in one reply.
>
> I want to talk about the DHT backend more with Scott Chacon at the
> GitTogether, but I have this feeling that just laying a pack file
> into a stream in a DHT is going to perform very poorly.
>
> Likewise JDBC has similar performance problems, you can only store
> so much in a row before performance of the RDBMS drops off sharply.
> You can get a handful of rows in a single reply pretty efficiently,
> but each query takes longer than you'd like. =A0Yes, there is often
> a BLOB type that allows large file storage, but different RDBMS
> support these differently and have different performance when it
> comes to accessing the BLOB types. =A0Some don't support random acces=
s,
> some do. =A0Even if they do support random access read, writing a lar=
ge
> 2 GiB repository's pack file after repacking it would take ages.
>
> Once you get outside of the pack file, *everything* else git stores
> is either a loose object, or very tiny text files (aka refs, their
> logs, config). =A0The loose object case should be handled by the same
> thing that handles the bulk of the object store, loose objects are
> a trivial thing compared to packed objects.
>
> The refs, the ref logs, and the config are all structured text.
> If you lay a Git repository down into a database of some sort,
> I think its reasonable to expect that the schema for these items
> in that database permits query and update using relatively native
> primitives in that database. =A0E.g. if you put this in SQL I would
> expect a schema like:
>
> =A0CREATE TABLE refs (
> =A0 repository_id INT NOT NULL
> =A0,name VARCHAR(255) NOT NULL
> =A0,id CHAR(40)
> =A0,target VARCHAR(255)
> =A0,PRIMARY KEY (repository_id, name)
> =A0,CHECK (id IS NOT NULL OR target IS NOT NULL));
>
> =A0CREATE TABLE reflogs (
> =A0 repository_id INT NOT NULL
> =A0,name VARCHAR(255) NOT NULL
> =A0,old_id CHAR(40) NOT NULL
> =A0,new_id CHAR(40) NOT NULL
> =A0,committer_name VARCHAR(255)
> =A0,committer_email VARCHAR(255)
> =A0,committer_date TIMESTAMP NOT NULL
> =A0,message VARCHAR(255)
> =A0,PRIMARY KEY (repository_id, name, committer_date));
>
> =A0CREATE TABLE config (
> =A0 repository_id INT NOT NULL
> =A0,section VARCHAR(255) NOT NULL
> =A0,group VARCHAR(255)
> =A0,name VARCHAR(255) NOT NULL
> =A0,value VARCHAR(255)
> =A0,PRIMARY KEY(repository_id, section, group, name, value))
>
> This makes it easier to manipulate settings, you can use direct
> SQL UPDATE to modify the configuration, or SELECT to scan through
> reflogs. =A0Etc.
>
> If we just threw everything as streams into the database this
> would be a lot more difficult to work with through the database's
> own native query and update interface. =A0You'd lose alot of the
> benefits of using a database, but still be paying the massive price
> in performance.
>

To be honest I understood your point the last time you mentioned it
:). I agree with performance part fully and I too have doubts, that is
why while you were mentioning HBase, I was HDFS :) and I was actually
thinking of in terms of FS. But after your elaboration, it just makes
more sense for the changes -
* Firstly we decouple from a particular FS and have our own I/O, for
packed and loose objects, so that we can easily retain the current
behavior.
* Then we first rework the key objects, e.g. Refs, Configs etc. to
segregate their persistence, that is introduce their persistence layer
which should friendly enough for native operations for platforms such
as RDBMS or HBase or BigTable. Using packs will depend of setup and
repositories, but certain implementations
* We implement this SPI to support different persistence platforms then=
 :).

The thing is I first want to make JGit independent of java.io.File :),
thats was my motto to start with, but you showed me a path beyond that
:) and that is free from java.io.File and optimized persistence API
:). I want to have them both and let the implementor choose how to
implement it :).

>> I am not thinking of storing "only" the bare content of a git
>> repository, but I intent to be able to also store the versioned
>> contents it self as well.
>
> When I say "bare repository" I only mean a repository without a
> working directory. =A0It still holds the complete revision history.
> If you wanted a git repository on Cassandra but wanted to actually
> have a working directory checkout, you'd need the local filesystem
> for the checkout and .git/index, but could otherwise keep the objects
> and refs in Cassandra. =A0Its nuts... but in theory one could do it.
>

My requirement also involves needing to check it out on HDFS :), that
is why I was mentioning it, but it could be a different topic other
than that of JGit.

Eagerly waiting for a reply.

Thank you,

--=20
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
