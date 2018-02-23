Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25E701F404
	for <e@80x24.org>; Fri, 23 Feb 2018 17:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeBWRXa (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 12:23:30 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:44974 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751547AbeBWRX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 12:23:29 -0500
Received: by mail-qt0-f182.google.com with SMTP id g60so11381618qtd.11
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 09:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yGvMuzYMWrWBxGQY288d+2ohgqZiA0aRQobc5StGcbs=;
        b=GYH87TxHK741v+e9vqk//pn4IW/jVUO0S7/FNe8V4DZVAcMU67+Z/EZnCAzXBhfLRm
         2kflzSfR05R+nevmO6I4docssHu5et9YrcjOJTWzzfJDstAOnIGf3qJw+dFhIRc6ood6
         9qIEfPmrvgepV2fBWCwaPnXk+ALwth48Q4D6hGxTaiU6lpO1oqWSpVr2qhMpi2AP9NB2
         +cIMV97g19zUwpIwqg3NQmGAuk49vVM/QJt9QadjIiUxnD1UKh/vscmT+YcJ6MB/B5xk
         M0WA8oofHfsPXoADjJa31Xu+jpF3rrqROPu2UQZA72YlO/NgGIP7zwDq6nu7vJAUdzs5
         /qMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yGvMuzYMWrWBxGQY288d+2ohgqZiA0aRQobc5StGcbs=;
        b=E8NzPG9cr7A/SkusT8X46+wfhfKP3Dx3XBJtd4oefrfurbewoniw4+xOjOA8/fzE3M
         EScboSOrB6AVzTBRH31zGAw8zGjKu/RzS7PejZYs2A7js8KjiXvrAHjdSFfgWT7lw9xM
         Pq3BEwxDD4aQe91XONkxZXKpySUuveOjkJz4JbRz0nlnN2Ynj2RXY/W3xp/Os4+w6XBz
         i+XzoQI//C1Lbbwt5HIk6XHtcIgnjx3WvrKtog5TUjhogcxXPXfW+1XRQVHZk59lg66J
         SrVRBc52jgm6XW+CD5JtFFuOar/CaHWLtQt6QLcm9WmvF0IyWSZexoeNWmF9NGp1rl4y
         XBxg==
X-Gm-Message-State: APf1xPAK55nihofYVyyns17RzI9p+0JHnAaEr0TLTzvzGCpbIkummTCP
        MFnwHWyIZSbVmt07oYrOuDk=
X-Google-Smtp-Source: AG47ELsULOwMDAH/cbctSugepu5K5HR/+BmDY4s6ZcBXEK7pmM7W8t1hSHRP68zkzZq/JuEyfxYVYw==
X-Received: by 10.200.19.138 with SMTP id h10mr3794058qtj.300.1519406608614;
        Fri, 23 Feb 2018 09:23:28 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id z67sm1674321qke.19.2018.02.23.09.23.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Feb 2018 09:23:27 -0800 (PST)
Subject: Re: [PATCH v4 04/13] commit-graph: implement write_commit_graph()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
 <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
 <1519066406-81663-5-git-send-email-dstolee@microsoft.com>
 <xmqqmv031d7d.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4d453f29-8e5b-2a98-ab11-415f63613be8@gmail.com>
Date:   Fri, 23 Feb 2018 12:23:26 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqmv031d7d.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/20/2018 5:57 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> +#define GRAPH_OID_VERSION_SHA1 1
>> +#define GRAPH_OID_LEN_SHA1 20
> This hardcoded 20 on the right hand side of this #define is probably
> problematic.   Unless you are planning to possibly store truncated
> hash value for some future hash algorithm, GRAPH_OID_LEN_$HASH should
> always be the same as GIT_$HASH_RAWSZ, I would think.  IOW
>
>      #define GRAPH_OID_LEN_SHA1 GIT_SHA1_RAWSZ
>
> perhaps?

Yes.

>
>> +static void write_graph_chunk_fanout(struct sha1file *f,
>> +				     struct commit **commits,
>> +				     int nr_commits)
>> +{
>> +	uint32_t i, count = 0;
>> +	struct commit **list = commits;
>> +	struct commit **last = commits + nr_commits;
>> +
>> +	/*
>> +	 * Write the first-level table (the list is sorted,
>> +	 * but we use a 256-entry lookup to be able to avoid
>> +	 * having to do eight extra binary search iterations).
>> +	 */
>> +	for (i = 0; i < 256; i++) {
>> +		while (list < last) {
>> +			if ((*list)->object.oid.hash[0] != i)
>> +				break;
>> +			count++;
>> +			list++;
>> +		}
> If count and list are always incremented in unison, perhaps you do
> not need an extra variable "last".  If typeof(nr_commits) is wider
> than typeof(count), this loop and the next write-be32 is screwed
> anyway ;-)
>
> This comment probably applies equally to some other uses of the same
> "compute last pointer to compare with running pointer for
> termination" pattern in this patch.

Yes. Also turning i and count into int to match nr_commits.

>
>> +		sha1write_be32(f, count);
>> +	}
>> +}
>> +static int commit_pos(struct commit **commits, int nr_commits,
>> +		      const struct object_id *oid, uint32_t *pos)
>> +{
> It is a bit unusual to see something_pos() that returns an integer
> that does *NOT* return the position as its return value.  Dropping
> the *pos parameter, and returning "mid" when commits[mid] is what we
> wanted to see, and otherwise returning "-1 - first" to signal the
> position at which we _would_ have found the object, if it were in
> the table, would make it more consistent with the usual convention.

I can make this change. I found the boolean return to make the 
consumer's logic simpler, but it isn't that much simpler.

> Don't we even have such a generalized binary search helper already
> somewhere in the system?

jt/binsearch-with-fanout introduces one when there is a 256-entry fanout 
table (not the case here).

The bsearch() method in search.h (and used in 
pack-write.c:need_large_offset) does not return the _position_ of a 
found element.

Neither of these suit my needs, but I could just be searching for the 
wrong strings. Also, I could divert my energies in this area to create a 
generic search in the style of jt/binsearch-with-fanout.

>
>> +static void write_graph_chunk_data(struct sha1file *f, int hash_len,
>> +				   struct commit **commits, int nr_commits)
>> +{
>> +	struct commit **list = commits;
>> +	struct commit **last = commits + nr_commits;
>> +	uint32_t num_large_edges = 0;
>> +
>> +	while (list < last) {
>> +		struct commit_list *parent;
>> +		uint32_t int_id;
>> +		uint32_t packedDate[2];
>> +
>> +...
>> +		if (!parent)
>> +			int_id = GRAPH_PARENT_NONE;
>> +		else if (parent->next)
>> +			int_id = GRAPH_LARGE_EDGES_NEEDED | num_large_edges;
>> +		else if (!commit_pos(commits, nr_commits,
>> +				    &(parent->item->object.oid), &int_id))
>> +			int_id = GRAPH_PARENT_MISSING;
>> +
>> +		sha1write_be32(f, int_id);
>> +
>> +		if (parent && parent->next) {
> This is equivalent to checking "int_id & GRAPH_LARGE_EDGES_NEEDED",
> right?  Not suggesting to use the other form of checks, but trying
> to see what's the best way to express it in the most readable way.

You're right, we already set the bit above, so let's make use of that 
check. Important to note that GRAPH_LARGE_EDGES_NEEDED & 
GRAPH_PARENT_MISSING == 0.

>
>> +			do {
>> +				num_large_edges++;
>> +				parent = parent->next;
>> +			} while (parent);
> It feels somewhat wasteful to traverse the commit's parents list
> only to count, without populating the octopus table (which I
> understand is assumed to be minority case under this design).

Since we are writing the commit graph file in-order, we cannot write the 
octopus table until after the chunk lengths are known. We could store 
the octopus table in memory and then dump it into the file later, but 
walking the parents is quite fast after all the commits are loaded. I'm 
not sure the time optimization merits the extra complexity here. (I'm 
happy to revisit this if we do see this performance lacking.)

P.S. I really like the name "octopus table" and will use that for 
informal discussions of this format.

>
>> +		}
>> +
>> +		if (sizeof((*list)->date) > 4)
>> +			packedDate[0] = htonl(((*list)->date >> 32) & 0x3);
>> +		else
>> +			packedDate[0] = 0;
> OK, the undefined pattern in the previous round is now gone ;-)  Good.
>
>> +		packedDate[1] = htonl((*list)->date);
>> +		sha1write(f, packedDate, 8);
>> +
>> +		list++;
>> +	}
>> +}
>> +
>> +static void write_graph_chunk_large_edges(struct sha1file *f,
>> +					  struct commit **commits,
>> +					  int nr_commits)
>> +{
>> +	struct commit **list = commits;
>> +	struct commit **last = commits + nr_commits;
>> +	struct commit_list *parent;
>> +
>> +	while (list < last) {
>> +		int num_parents = 0;
>> +		for (parent = (*list)->parents; num_parents < 3 && parent;
>> +		     parent = parent->next)
>> +			num_parents++;
>> +
>> +		if (num_parents <= 2) {
>> +			list++;
>> +			continue;
>> +		}
>> +
>> +		/* Since num_parents > 2, this initializer is safe. */
>> +		for (parent = (*list)->parents->next; parent; parent = parent->next) {
>> +			uint32_t int_id, swap_int_id;
>> +			uint32_t last_edge = 0;
>> +			if (!parent->next)
>> +				last_edge |= GRAPH_LAST_EDGE;
>> +
>> +			if (commit_pos(commits, nr_commits,
>> +				       &(parent->item->object.oid),
>> +				       &int_id))
>> +				swap_int_id = htonl(int_id | last_edge);
>> +			else
>> +				swap_int_id = htonl(GRAPH_PARENT_MISSING | last_edge);
>> +			sha1write(f, &swap_int_id, 4);
> What does "swap_" in the name of this variable mean?  For some
> archs, there is no swap.  The only difference between int_id and the
> variable is that its MSB may possibly be smudged with last_edge bit.

Sorry, I tried to catch all of these, but some fell through the cracks. 
I should be using sha1write_be32() after modifying int_id directly.

This whole block is a bit of a mess. I'll replace it with something like:

                         uint32_t int_id;
                         if (!commit_pos(commits, nr_commits,
&(parent->item->object.oid),
                                        &int_id))
                                 int_id = GRAPH_PARENT_MISSING;
                         else if (!parent->next)
                                 int_id |= GRAPH_LAST_EDGE;

                         sha1write_be32(f, int_id);

> This is a tangent, but after having seen many instances of "int_id",
> I started to feel that it is grossly misnamed.  We do not care about
> its "int" ness---what's more significant about it is that we use can
> it as a short identifier in place for a full object name, given the
> table of known OIDs.  "oid_table_index" may be a better name (but
> others may be able to suggest even better one).
>
> 	int pos;
> 	pos = commit_pos(commits, nr_commits, parent->item->object.oid);
> 	oid_table_pos = (pos < 0) ? GRAPH_PARENT_MISSING : pos;
> 	if (!parent->net)
> 		oid_table_pos |= GRAPH_LAST_EDGE;
> 	oid_table_pos = htonl(oid_table_pos);
> 	sha1write(f, &oid_table_pos, sizeof(oid_table_pos));
>
> or something like that, perhaps?

You're right that int_id isn't great, and your more-specific 
"oid_table_pos" shows an extra reason why it isn't great: when we add 
the GRAPH_LAST_EDGE bit or set it to GRAPH_PARENT_MISSING, the value is 
NOT a table position.

I'll rework references of "int_id" into "edge_value" to store a value 
that goes into - or is read from - the file, either in the two parent 
columns or the octopus table.

>
>> +static int commit_compare(const void *_a, const void *_b)
>> +{
>> +	struct object_id *a = (struct object_id *)_a;
>> +	struct object_id *b = (struct object_id *)_b;
>> +	return oidcmp(a, b);
>> +}
> I think oidcmp() takes const pointers, so there is no need to
> discard constness from the parameter like this code does.  Also I
> think we tend to prefer writing a_/b_ (instead of _a/_b) to appease
> language lawyers who do not want us mere mortals to use names that
> begin with underscore.
>
>> +static int if_packed_commit_add_to_list(const struct object_id *oid,
>> +					struct packed_git *pack,
>> +					uint32_t pos,
>> +					void *data)
> That is a strange name.  "collect packed commits", perhaps?

We are walking all objects in the pack-index and calling this method. If 
the object is a commit, we add it to the list; otherwise do nothing. 
"data" points to the list.

I think the current name makes the following call very clear:

   for_each_object_in_pack(p, if_packed_commit_add_to_list, &oids);

i.e. "for each object in the pack p: if it is a commit, then add it to 
the list of oids".

>
>> +char *write_commit_graph(const char *obj_dir)
>> +{
>> +	struct packed_oid_list oids;
>> +	struct packed_commit_list commits;
>> +	struct sha1file *f;
>> +	int i, count_distinct = 0;
>> +	DIR *info_dir;
>> +	struct strbuf tmp_file = STRBUF_INIT;
>> +	struct strbuf graph_file = STRBUF_INIT;
>> +	unsigned char final_hash[GIT_MAX_RAWSZ];
>> +	char *graph_name;
>> +	int fd;
>> +	uint32_t chunk_ids[5];
>> +	uint64_t chunk_offsets[5];
>> +	int num_chunks;
>> +	int num_long_edges;
>> +	struct commit_list *parent;
>> +
>> +	oids.nr = 0;
>> +	oids.alloc = (int)(0.15 * approximate_object_count());
> Heh, traditionalist would probably avoid unnecessary use of float
> and use something like 1/4 or 1/8 ;-)  After all, it is merely a
> ballpark guestimate.
>
>> +	num_long_edges = 0;
> This again is about naming, but I find it a bit unnatural to call
> the edge between a chind and its octopus parents "long".  Individual
> edges are not long--the only thing that is long is your "list of
> edges".  Some other codepaths in this patch seems to call the same
> concept with s/long/large/, which I found somewhat puzzling.

How about "num_extra_edges" which counts the "overflow" into the octopus 
table. Note: "num_octopus_edges" sounds like summing the out-degree of 
octopus merges, but this count is really "(total number of parents of 
octopus merges) - (number of octopus merges)".

>
>> +	for (i = 0; i < oids.nr; i++) {
>> +		int num_parents = 0;
>> +		if (i > 0 && !oidcmp(&oids.list[i-1], &oids.list[i]))
>> +			continue;
>> +
>> +		commits.list[commits.nr] = lookup_commit(&oids.list[i]);
>> +		parse_commit(commits.list[commits.nr]);
>> +
>> +		for (parent = commits.list[commits.nr]->parents;
>> +		     parent; parent = parent->next)
>> +			num_parents++;
>> +
>> +		if (num_parents > 2)
>> +			num_long_edges += num_parents - 1;
> OK, so we count how many entries we will record in the overflow
> parent table, and...
>
>> +
>> +		commits.nr++;
>> +	}
>> +	num_chunks = num_long_edges ? 4 : 3;
> ... if we do not have any octopus commit, we do not need the chunk
> for the overflow parent table.  Makes sense.
>
>> +	strbuf_addf(&tmp_file, "%s/info", obj_dir);
>> +	info_dir = opendir(tmp_file.buf);
>> +
>> +	if (!info_dir && mkdir(tmp_file.buf, 0777) < 0)
>> +		die_errno(_("cannot mkdir %s"), tmp_file.buf);
>> +	if (info_dir)
>> +		closedir(info_dir);
>> +	strbuf_addstr(&tmp_file, "/tmp_graph_XXXXXX");
>> +
>> +	fd = git_mkstemp_mode(tmp_file.buf, 0444);
>> +	if (fd < 0)
>> +		die_errno("unable to create '%s'", tmp_file.buf);
> It is not performance critical, but it feels a bit wasteful to
> opendir merely to see if something exists as a directory, and it is
> misleading to the readers (it looks as if we care about what files
> we already have in the directory).
>
> The approach that optimizes for the most common case would be to
>
> 	- prepare full path to the tempfile first
> 	- try create with mkstemp
> 	  - if successful, you do not have to worry about creating
> 	    the directory at all, which is the most common case
>          - see why mkstemp step above failed.  Was it because you
> 	  did not have the surrounding directory?
>            - if not, there is no point continuing.  Just error out.
> 	  - if it was due to missing directory, try creating one.
> 	- try create with mkstemp
> 	  - if successful, all is well.
>          - otherwise there isn't anything more we can do here.

It looks like sha1_file.c:create_tmpfile() has code I can use as a model 
here. Thanks.

I wonder: should we move that method into wrapper.c and have its 
external definition be available in cache.h? Then I can just consume it 
from here.

>
>> +
>> +	f = sha1fd(fd, tmp_file.buf);
>> +
>> +	sha1write_be32(f, GRAPH_SIGNATURE);
>> +
>> +	sha1write_u8(f, GRAPH_VERSION);
>> +	sha1write_u8(f, GRAPH_OID_VERSION);
>> +	sha1write_u8(f, num_chunks);
>> +	sha1write_u8(f, 0); /* unused padding byte */
>> +
>> +	chunk_ids[0] = GRAPH_CHUNKID_OIDFANOUT;
>> +	chunk_ids[1] = GRAPH_CHUNKID_OIDLOOKUP;
>> +	chunk_ids[2] = GRAPH_CHUNKID_DATA;
>> +	if (num_long_edges)
>> +		chunk_ids[3] = GRAPH_CHUNKID_LARGEEDGES;
>> +	else
>> +		chunk_ids[3] = 0;
>> +	chunk_ids[4] = 0;
>> +
>> +	chunk_offsets[0] = 8 + GRAPH_CHUNKLOOKUP_SIZE;
>> +	chunk_offsets[1] = chunk_offsets[0] + GRAPH_FANOUT_SIZE;
>> +	chunk_offsets[2] = chunk_offsets[1] + GRAPH_OID_LEN * commits.nr;
>> +	chunk_offsets[3] = chunk_offsets[2] + (GRAPH_OID_LEN + 16) * commits.nr;
>> +	chunk_offsets[4] = chunk_offsets[3] + 4 * num_long_edges;
> Do we have to care about overflowing any of the above?  For example,
> the format allows only up to (1<<31)-1 commits, but did something
> actually check if commits.nr at this point stayed under that limit?

Thanks for pointing this out. It should be a while before we have a repo 
with 2 billion commits, but there's no time like the present to be safe.

Thanks,
-Stolee
