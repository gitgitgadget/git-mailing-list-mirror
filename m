From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] prefer xwrite instead of write
Date: Fri, 17 Jan 2014 10:21:48 -0800
Message-ID: <20140117182148.GY18964@google.com>
References: <1389968230-1224-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: msysgit+bncBD6LRKOE4AIRBP7J4WLAKGQEOARKVHY@googlegroups.com Fri Jan 17 19:21:55 2014
Return-path: <msysgit+bncBD6LRKOE4AIRBP7J4WLAKGQEOARKVHY@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qc0-f190.google.com ([209.85.216.190])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBD6LRKOE4AIRBP7J4WLAKGQEOARKVHY@googlegroups.com>)
	id 1W4E3F-0005AA-4G
	for gcvm-msysgit@m.gmane.org; Fri, 17 Jan 2014 19:21:53 +0100
Received: by mail-qc0-f190.google.com with SMTP id c9sf887672qcz.27
        for <gcvm-msysgit@m.gmane.org>; Fri, 17 Jan 2014 10:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :in-reply-to:user-agent:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type:content-disposition;
        bh=Vj7e793/BYXbUfYBERo9Me6GrSzRtMOm9excoGW0Tl8=;
        b=VDMgKDES6ZYoaXpqPKJoLl7FCCDlmDUqVaRBmlxGAZ3i+U08JB5DMN6ckfeLlILLbe
         87PqyefhNOFFFLR8IDsuxPbVvVHd/lXl9rFfil7vkEAaRTjlZA4cMQ5UO8rj4igy0VYu
         0Bt4pKmKXSVy7WXyv+S/y63kkzgWVa53uT+zqJ1aiW+3cGhaqmTFm/NWMjWfouP7b6nJ
         gceXO6EYfOvMEVO4rb2Bf6wjk+8o2257O/UpP2dm9JTjKq+k4ih3LoVlBKAgypdoTpZg
         cga6cZckinTXY1WiaZS1QKYQ7b5DQxPSQ1UUtaokm6Ooy6A1/5SpfPu7LRzf2+wUdJZW
         BKCA==
X-Received: by 10.140.94.11 with SMTP id f11mr93700qge.7.1389982912353;
        Fri, 17 Jan 2014 10:21:52 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.140.87.134 with SMTP id r6ls530471qgd.47.gmail; Fri, 17 Jan
 2014 10:21:51 -0800 (PST)
X-Received: by 10.236.118.12 with SMTP id k12mr1192096yhh.35.1389982911653;
        Fri, 17 Jan 2014 10:21:51 -0800 (PST)
Received: from mail-yh0-x236.google.com (mail-yh0-x236.google.com [2607:f8b0:4002:c01::236])
        by gmr-mx.google.com with ESMTPS id 48si3798474yhf.7.2014.01.17.10.21.51
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 10:21:51 -0800 (PST)
Received-SPF: pass (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:4002:c01::236 as permitted sender) client-ip=2607:f8b0:4002:c01::236;
Received: by mail-yh0-x236.google.com with SMTP id b12so1527206yha.27
        for <msysgit@googlegroups.com>; Fri, 17 Jan 2014 10:21:51 -0800 (PST)
X-Received: by 10.236.100.173 with SMTP id z33mr3209604yhf.9.1389982911472;
        Fri, 17 Jan 2014 10:21:51 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id c44sm19565587yho.20.2014.01.17.10.21.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 10:21:50 -0800 (PST)
In-Reply-To: <1389968230-1224-1-git-send-email-kusmabite@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Original-Sender: jrnieder@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of jrnieder@gmail.com designates 2607:f8b0:4002:c01::236
 as permitted sender) smtp.mail=jrnieder@gmail.com;       dkim=pass
 header.i=@gmail.com;       dmarc=pass (p=NONE dis=NONE) header.from=gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Content-Disposition: inline
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240605>

Hi,

Erik Faye-Lund wrote:

> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -367,7 +367,7 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
>  			sha1_to_hex(commit->object.sha1));
>  		pretty_print_commit(&ctx, commit, &out);
>  	}
> -	if (write(fd, out.buf, out.len) < 0)
> +	if (xwrite(fd, out.buf, out.len) < 0)
>  		die_errno(_("Writing SQUASH_MSG"));

Shouldn't this use write_in_full() to avoid a silently truncated result? (*)

[...]
> --- a/streaming.c
> +++ b/streaming.c
> @@ -538,7 +538,7 @@ int stream_blob_to_fd(int fd, unsigned const char *sha1, struct stream_filter *f
>  			goto close_and_exit;
>  	}
>  	if (kept && (lseek(fd, kept - 1, SEEK_CUR) == (off_t) -1 ||
> -		     write(fd, "", 1) != 1))
> +		     xwrite(fd, "", 1) != 1))

Yeah, if we get EINTR then it's worth retrying.

[...]
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -1129,9 +1129,8 @@ static int udt_do_write(struct unidirectional_transfer *t)
>  		return 0;	/* Nothing to write. */
>  
>  	transfer_debug("%s is writable", t->dest_name);
> -	bytes = write(t->dest, t->buf, t->bufuse);
> -	if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
> -		errno != EINTR) {
> +	bytes = xwrite(t->dest, t->buf, t->bufuse);
> +	if (bytes < 0 && errno != EWOULDBLOCK) {

Here the write is limited by BUFFERSIZE, and returning to the outer
loop to try another read when the write returns EAGAIN, like the
original code does, seems philosophically like the right thing to do.

Luckily we don't use O_NONBLOCK anywhere, so the change shouldn't
matter in practice.  So although it doesn't do any good, using xwrite
here for consistency should be fine.

So my only worry is the (*) above.  With that change,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

-- 
-- 
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=en_US?hl=en

--- 
You received this message because you are subscribed to the Google Groups "msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an email to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
