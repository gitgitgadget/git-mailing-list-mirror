From: Stefan Zager <szager@chromium.org>
Subject: Re: [PATCH] Enable index-pack threading in msysgit.
Date: Thu, 20 Mar 2014 22:35:52 -0700
Message-ID: <CAHOQ7J8eEUd+NpL78RQqGFYzhD9Fs0hdGOHhmXiujJdGrfeS=A@mail.gmail.com>
References: <5328e903.joAd1dfenJmScBNr%szager@chromium.org>
	<532AF304.7040301@gmail.com>
	<CAHOQ7J9drXwcTt4b0Tcyw97KTGcifwsO5rtFNQYf7CVr3WD7zQ@mail.gmail.com>
	<CACsJy8AYs0-rmGZz2_KEkT2ibW-sTpm=Q9FxFhNGRYd2b6R+sA@mail.gmail.com>
	<20140321052118.GA28519@duynguyen-vnpc.dek-tpc.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Zager <szager@chromium.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 06:36:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQs7b-00038s-W7
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 06:36:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616AbaCUFfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 01:35:54 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:43076 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754183AbaCUFfx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 01:35:53 -0400
Received: by mail-ob0-f170.google.com with SMTP id uz6so2034365obc.29
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 22:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=AnnlkozwMSfqtvZSblgMcPgn9/2cVhqwHy8dyzZWG80=;
        b=KzZQy6BtPSY8y97S7PSoi9LXusf7x+4bpU33o9E9m6n29HJ1lk8/vk2hYcVuNxCCvP
         thOzzeW42IlXdcDWwGT6eYx+vDCFDmn2L2NvSH0Dqo2cEekAuJA/GAdvEBqmKUcg2Ypq
         BVDMrkN7FBmYAUC9c4F4tl3KUdVScjXUOhvhEWeWc5Y2Sky8nCJr6vNvq30dj+X8x4kQ
         beVovnWCkYEPz16fSjMNa/Ldj7lEgS3d94TI96q4X40jwhbTfRwtEDJM5PpqDrc8Dvql
         doPhMVRfEM33XpypU9Hk5O2/12FwyX4iLWkhK086WR1Pb6zi+ZZlR4aQUPvmMg26YjMk
         CKpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=AnnlkozwMSfqtvZSblgMcPgn9/2cVhqwHy8dyzZWG80=;
        b=ihvHJQl/RB6EKDO0nHmvKHpMxArpaY6TQ0maTxn7EXs8y5p3/wj/tQ2HYo2apmAc8o
         7KjizgrTwiwR96dfxCe3Ont1gcxBu65Hn7qitgxG7QG3cisE7RqMP6InpNv+qhPeW1Iz
         gS+tdaJFgubsmofhP6MhblKwEn8vmf+oFcaiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=AnnlkozwMSfqtvZSblgMcPgn9/2cVhqwHy8dyzZWG80=;
        b=WHTzksjTLboVgcrvEiwCsGRhSJFSfRtiMOV2jScVGzyfRVsilkZvXo3YF+vqOLu+kq
         B25/Mmcn9TVwHzGhHV/AZG2SUQ7H21JCTJbIw7m1mgqalJnaJeOrdoPQbtckmME3f86w
         H/s8Dsa62GYQkSr5iRO2gyS9VdKqVsjWLkJdpSqWAvk1QLd/vrT5XLptYvYedim3OWOw
         SPSZuKL5SyJXH8nSAoyJMDX8dLqfsSgdIK0/0WMctePrZOXNn2wOCdMCVSilE9u3im2s
         2MtsI8Hg5v28j5BOWsU6CerYRkX9IAeRE/TNKnVbtt6NswPrenLiCMF/scsvrNMc2uMl
         dMeg==
X-Gm-Message-State: ALoCoQmrY8ICTk9rFlalFd0mK+D4azpX3znAyK3iyvhBv5HxNxN9USH3ONpZRR91GhA1x7P07CLPsjA3i4uGF5eBvIxZNnaCX6LT6PBLDnIhafHluA1fuATWQWUZH5Rn/ywXUQkpXzXu4wfGjs5NyR/GBdq5QnXao6hZuDM88c8+GzpI8hyPKPuJ3GR2f1CrryxULOEUj4pY
X-Received: by 10.60.80.162 with SMTP id s2mr41275927oex.10.1395380152312;
 Thu, 20 Mar 2014 22:35:52 -0700 (PDT)
Received: by 10.182.233.201 with HTTP; Thu, 20 Mar 2014 22:35:52 -0700 (PDT)
In-Reply-To: <20140321052118.GA28519@duynguyen-vnpc.dek-tpc.internal>
X-Google-Sender-Auth: k9AY9zEK_21XUsOx7CA-B_2uKDw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244641>

On Thu, Mar 20, 2014 at 10:21 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Mar 21, 2014 at 08:51:18AM +0700, Duy Nguyen wrote:
>> On Thu, Mar 20, 2014 at 11:08 PM, Stefan Zager <szager@chromium.org> wrote:
>> > Duy, would you like to re-post your patch without the new pread implementation?
>>
>> I will but let me try out the sliding window idea first. My quick
>> tests on git.git show me we may only need 21k mmap instead of 177k
>> pread. That hints some potential performance improvement.
>
> The patch at the bottom reuses (un)use_pack() instead of pread(). The
> results on linux-2.6 do not look any different. I guess we can drop
> the idea.
>
> It makes me wonder, though, what's wrong a simple patch like this to
> make pread in index-pack thread-safe? It does not look any different
> either from the performance point of view, perhaps because
> unpack_data() reads small deltas most of the time

When you serialize disk access in this way, the effect on performance
is really dependent on the behavior of the OS, as well as the locality
of the read offsets.  Assuming -- fairly, I think -- that the reads
will be pretty randomly distributed (i.e., no locality to speak of),
then your best bet is get as many read operations in flight as
possible, and let the disk scheduler optimize the seek time.

If I have a chance, I will try out this patch in msysgit on the
chromium repositories.

>
> -- 8< --
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index a6b1c17..b91f4f8 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -40,11 +40,6 @@ struct base_data {
>         int ofs_first, ofs_last;
>  };
>
> -#if !defined(NO_PTHREADS) && defined(NO_THREAD_SAFE_PREAD)
> -/* pread() emulation is not thread-safe. Disable threading. */
> -#define NO_PTHREADS
> -#endif
> -
>  struct thread_local {
>  #ifndef NO_PTHREADS
>         pthread_t thread;
> @@ -175,6 +170,22 @@ static void cleanup_thread(void)
>  #endif
>
>
> +#if defined(NO_THREAD_SAFE_PREAD)
> +static inline ssize_t pread_safe(int fd, void *buf, size_t count, off_t off)
> +{
> +       int ret;
> +       read_lock();
> +       ret = pread(fd, buf, count, off);
> +       read_unlock();
> +       return ret;
> +}
> +#else
> +static inline ssize_t pread_safe(int fd, void *buf, size_t count, off_t off)
> +{
> +       return pread(fd, buf, count, off);
> +}
> +#endif
> +
>  static int mark_link(struct object *obj, int type, void *data)
>  {
>         if (!obj)
> @@ -542,7 +553,7 @@ static void *unpack_data(struct object_entry *obj,
>
>         do {
>                 ssize_t n = (len < 64*1024) ? len : 64*1024;
> -               n = pread(pack_fd, inbuf, n, from);
> +               n = pread_safe(pack_fd, inbuf, n, from);
>                 if (n < 0)
>                         die_errno(_("cannot pread pack file"));
>                 if (!n)
> -- 8< --
>
> And the sliding window patch for the list archive
>
> -- 8< --
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index a6b1c17..6f5c6d9 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -91,7 +91,8 @@ static off_t consumed_bytes;
>  static unsigned deepest_delta;
>  static git_SHA_CTX input_ctx;
>  static uint32_t input_crc32;
> -static int input_fd, output_fd, pack_fd;
> +static int input_fd, output_fd;
> +static struct packed_git *pack;
>
>  #ifndef NO_PTHREADS
>
> @@ -224,8 +225,10 @@ static unsigned check_objects(void)
>  static void flush(void)
>  {
>         if (input_offset) {
> -               if (output_fd >= 0)
> +               if (output_fd >= 0) {
>                         write_or_die(output_fd, input_buffer, input_offset);
> +                       pack->pack_size += input_offset;
> +               }
>                 git_SHA1_Update(&input_ctx, input_buffer, input_offset);
>                 memmove(input_buffer, input_buffer + input_offset, input_len);
>                 input_offset = 0;
> @@ -277,6 +280,10 @@ static void use(int bytes)
>
>  static const char *open_pack_file(const char *pack_name)
>  {
> +       pack = xmalloc(sizeof(*pack) + 1);
> +       memset(pack, 0, sizeof(*pack));
> +       pack->pack_name[0] = '\0';
> +
>         if (from_stdin) {
>                 input_fd = 0;
>                 if (!pack_name) {
> @@ -288,13 +295,17 @@ static const char *open_pack_file(const char *pack_name)
>                         output_fd = open(pack_name, O_CREAT|O_EXCL|O_RDWR, 0600);
>                 if (output_fd < 0)
>                         die_errno(_("unable to create '%s'"), pack_name);
> -               pack_fd = output_fd;
> +               pack->pack_fd = output_fd;
>         } else {
> +               struct stat st;
>                 input_fd = open(pack_name, O_RDONLY);
>                 if (input_fd < 0)
>                         die_errno(_("cannot open packfile '%s'"), pack_name);
> +               if (lstat(pack_name, &st))
> +                       die_errno(_("cannot stat packfile '%s'"), pack_name);
>                 output_fd = -1;
> -               pack_fd = input_fd;
> +               pack->pack_fd = input_fd;
> +               pack->pack_size = st.st_size;
>         }
>         git_SHA1_Init(&input_ctx);
>         return pack_name;
> @@ -531,9 +542,15 @@ static void *unpack_data(struct object_entry *obj,
>         unsigned char *data, *inbuf;
>         git_zstream stream;
>         int status;
> +       struct pack_window *w_cursor = NULL;
> +
> +       if (from + len > pack->pack_size)
> +               die(Q_("premature end of pack file, %lu byte missing",
> +                      "premature end of pack file, %lu bytes missing",
> +                      from + len - pack->pack_size),
> +                   (unsigned long)(from + len - pack->pack_size));
>
>         data = xmalloc(consume ? 64*1024 : obj->size);
> -       inbuf = xmalloc((len < 64*1024) ? len : 64*1024);
>
>         memset(&stream, 0, sizeof(stream));
>         git_inflate_init(&stream);
> @@ -541,15 +558,12 @@ static void *unpack_data(struct object_entry *obj,
>         stream.avail_out = consume ? 64*1024 : obj->size;
>
>         do {
> -               ssize_t n = (len < 64*1024) ? len : 64*1024;
> -               n = pread(pack_fd, inbuf, n, from);
> -               if (n < 0)
> -                       die_errno(_("cannot pread pack file"));
> -               if (!n)
> -                       die(Q_("premature end of pack file, %lu byte missing",
> -                              "premature end of pack file, %lu bytes missing",
> -                              len),
> -                           len);
> +               ssize_t n;
> +               unsigned long left;
> +               read_lock();
> +               inbuf = use_pack(pack, &w_cursor, from, &left);
> +               read_unlock();
> +               n = left > len ? len : left;
>                 from += n;
>                 len -= n;
>                 stream.next_in = inbuf;
> @@ -568,6 +582,9 @@ static void *unpack_data(struct object_entry *obj,
>                                 stream.avail_out = 64*1024;
>                         } while (status == Z_OK && stream.avail_in);
>                 }
> +               read_lock();
> +               unuse_pack(&w_cursor);
> +               read_unlock();
>         } while (len && status == Z_OK && !stream.avail_in);
>
>         /* This has been inflated OK when first encountered, so... */
> @@ -575,7 +592,6 @@ static void *unpack_data(struct object_entry *obj,
>                 die(_("serious inflate inconsistency"));
>
>         git_inflate_end(&stream);
> -       free(inbuf);
>         if (consume) {
>                 free(data);
>                 data = NULL;
> @@ -1657,6 +1673,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
>         free(objects);
>         free(index_name_buf);
>         free(keep_name_buf);
> +       close_pack_windows(pack);
> +       free(pack);
>         if (pack_name == NULL)
>                 free((void *) curr_pack);
>         if (index_name == NULL)
> diff --git a/sha1_file.c b/sha1_file.c
> index 187f5a6..aa0b16d 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -977,7 +977,13 @@ unsigned char *use_pack(struct packed_git *p,
>          */
>         if (!p->pack_size && p->pack_fd == -1 && open_packed_git(p))
>                 die("packfile %s cannot be accessed", p->pack_name);
> -       if (offset > (p->pack_size - 20))
> +       /*
> +        * index-pack uses this function even if the pack is not
> +        * complete yet (i.e. trailing SHA-1 missing). Loosen the
> +        * check a bit in this case (pack_empty name uses as the
> +        * indicator).
> +        */
> +       if (offset > (p->pack_size - (*p->pack_name ? 20 : 0)))
>                 die("offset beyond end of packfile (truncated pack?)");
>
>         if (!win || !in_window(win, offset)) {
> -- 8< --
>
> --
> Duy
