Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42035C433FE
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 14:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238239AbiKWO64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 09:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238190AbiKWO6b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 09:58:31 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170B563B99
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 06:58:30 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id x17so16319271wrn.6
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 06:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BXUpc6WPgDhyayBhPnIjaxhO1CCYhVGWSzNR8jV+6SM=;
        b=GPEcbQwupaz/qv3HMYZYtPodxM8ysohvIgtunSeaoowlaobK4orjMwGrWdZGBQ9sZc
         6CbAwwmKKxjn/O76PAAwrvpoINwhuvdU6vtu9VqZwlgaizyDFGuzgYgQxmKACsRZIAZ9
         jra5bFINU77IkthGF9Nhc52vK511oxhs2VuEa4XgWF9HPO32sZihqHSbdJOSZbgPxIQb
         EFZ9cOxRZ0tB5h5h5lD/6HVKaqKRjE7en075A6FNEWBh2kW9F3sp99tlMHyM9XxgWIIa
         XU0P7YdO5MEydC233FxlAuzaiwSkYvTd3WfY4Fm4AnRXAfncfzwfPihgbexLUvWAkGxS
         OArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXUpc6WPgDhyayBhPnIjaxhO1CCYhVGWSzNR8jV+6SM=;
        b=lJwkSzVpQBiwhhYCYTg7iVLHIhN8q7Y/D9h0iUhIwRO1IGAk0xhs31OsWQNWF3mQKw
         pZU6KdaCVQknOkAvZU+5QrrrXg/ib0FtosUfYkFTgGvLSggDU+YwlIXNkGId9DZg7E13
         Rdn7JG9ZbQSIJLQztQDa60nNpcysgchEU9+cgUO8gVdyKBoqH1EBTdGsEFH75dy80t9H
         V7a0jqxx9EJz1saB6xuJ3xGGq4x9Y+h4odh9XCVnq1xao6dyuORT+m1U/WlOWMI+mXQ2
         zSBhH0ixvP2arLwDjlSZ6UvDvddRfRH7Y/J7HRSZSRj3wWCbLmvGGdBR4F80Hvh2MC5G
         E4KQ==
X-Gm-Message-State: ANoB5pmWQ9xCso4ByYLnk2GUKgZTrYE/j62SJto+caDj/eEJaRdxWw9c
        DUJk4Om5ee0s9DNL874K6nc=
X-Google-Smtp-Source: AA0mqf5XUOsFyyvoJqQD2Hd44/UjsLwrUkJ49fiJRwyygngAFwtBr/S5NaWYwRGY4m7lp5XXtFiBug==
X-Received: by 2002:adf:ee03:0:b0:241:c5c5:d48b with SMTP id y3-20020adfee03000000b00241c5c5d48bmr14157098wrn.464.1669215508463;
        Wed, 23 Nov 2022 06:58:28 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c510700b003cf5ec79bf9sm2827767wms.40.2022.11.23.06.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 06:58:28 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <feb7db00-db00-6190-47cf-9101052b9be8@dunelm.org.uk>
Date:   Wed, 23 Nov 2022 14:58:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 3/3] git-jump: invoke emacs/emacsclient
Content-Language: en-US
To:     Yoichi Nakayama via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
References: <pull.1423.v4.git.1669126703.gitgitgadget@gmail.com>
 <pull.1423.v5.git.1669187053.gitgitgadget@gmail.com>
 <ad7c299cb0f78ae3f36d57b67fa91e5ccaab3181.1669187053.git.gitgitgadget@gmail.com>
In-Reply-To: <ad7c299cb0f78ae3f36d57b67fa91e5ccaab3181.1669187053.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Yoichi

On 23/11/2022 07:04, Yoichi Nakayama via GitGitGadget wrote:
> From: Yoichi Nakayama <yoichi.nakayama@gmail.com>
> 
> It works with GIT_EDITOR="emacs", "emacsclient" or "emacsclient -t"
> 
> Signed-off-by: Yoichi Nakayama <yoichi.nakayama@gmail.com>
> ---
>   contrib/git-jump/git-jump | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
> index cc97b0dcf02..316e9628725 100755
> --- a/contrib/git-jump/git-jump
> +++ b/contrib/git-jump/git-jump
> @@ -23,7 +23,22 @@ EOF
>   
>   open_editor() {
>   	editor=`git var GIT_EDITOR`
> -	eval "$editor -q \$1"
> +	case "$editor" in
> +	*emacs*)
> +		# Supported editor values are:
> +		# - emacs
> +		# - emacsclient
> +		# - emacsclient -t
> +		#
> +		# Wait for completion of the asynchronously executed process
> +		# to avoid race conditions in case of "emacsclient".
> +		eval "$editor --eval \"(prog1 (pop-to-buffer (compilation-start \\\"cat $@\\\" 'grep-mode)) (while (get-buffer-process (current-buffer)) (sleep-for 0.1)) (select-frame-set-input-focus (selected-frame)))\""

I've just tried this out and it is much nicer than v4, thank you for 
tweaking it. It is a little sluggish to pop up the emacs window though - 
are you sure we need the while loop? I've commented it out and it seems 
to work just fine. The documentation for pop-to-buffer says it selects 
the frame displaying the buffer so I don't think we need to wait before 
calling select-frame-set-input-focus (I'm no emacs expert though). I do 
think it would be better to quote the filename or better still call 
git-jump from compilation-start as Peff suggested. It would also be nice 
to stop emacsclient from printing anything in the terminal.

It would be nice to be able to run git-jump from within emacs. I came up 
with the code below which prompts the user for the directory to run 
git-jump in (which only matters for grep and diff --relative I think) 
and then checks for modified buffers visiting files in that repository 
before running git-jump.

Best Wishes

Phillip

---- >8 ----
(require 'cl-lib)

(defun git-jump (dir)
   "Run 'git jump', prompts for the directory to run in. Also prompts to
    save modified buffers visiting files in the repository containing DIR"
   (interactive "DDirectory:")
   (let* ((dir (expand-file-name dir))
	 (worktree (git-jump--get-worktree dir)))
     (unless worktree
       (error "Not in a git repository"))
     (git-jump--save-worktree-buffers worktree)
     ;; Use "cd" rather than "git -C" so emacs can tell which directory
     ;; the command is being run in.
     (compilation-start (concat "cd " (shell-quote-argument dir)
			       " && git jump --stdout "
			       (read-string "Jump command: "))
		       'grep-mode
		       (lambda (mode) "*git-jump*"))))


(defun git-jump--save-worktree-buffers (worktree)
   "Prompt the user to save all the modified buffers in WORKTREE"
   (let ((ht (make-hash-table :test 'equal))
	(off (length worktree))
	(buffers nil))
     (dolist (b (buffer-list))
       (when (buffer-modified-p b)
	(let ((file (buffer-file-name b)))
	  (when file
	    (let ((path (file-truename file)))
	      (when (string-prefix-p worktree path)
		(puthash (substring path off) b ht)))))))
     (let ((modified (hash-table-keys ht)))
       (when modified
	(git-jump--ls-files worktree
			       modified
			       (lambda (path)
				 (push (gethash path ht) buffers)))
	(when buffers
	  (save-some-buffers nil (lambda ()
				   (memq (current-buffer) buffers))))))))


(defun git-jump--get-worktree (dir)
   "Get the git worktree containing DIR. Returns nil if DIR is not in a
    repository"
   (message (concat "dir: " dir))
   (let* ((toplevel "")
	    (filter (lambda (_proc text)
		      (setf toplevel (concat toplevel text))))
	    (proc (make-process :name "rev-parse--toplevel"
				:buffer nil
				:coding (or file-name-coding-system
					    default-file-name-coding-system)
				:command (list "git" "-C" dir "rev-parse"
					       "--show-toplevel")
				:connection-type 'pipe
				:filter filter)))
        (while (or (accept-process-output proc 120)
		  (not (memq (process-status proc) '(exit signal)))))
        (prog1
	   (if (and (eq (process-status proc) 'exit)
		    (zerop (process-exit-status proc)))
	       (concat (substring toplevel 0 -1) "/")
	     nil)
	 (delete-process proc))))


(defun git-jump--ls-files (worktree paths func)
   "Run FUNC on PATHS that are tracked by worktree. NB takes paths not 
pathspecs"
   (let* ((remainder "")
	 (filter (lambda (_proc text)
		   (let* ((text (concat remainder text))
			  (len (length text))
			  (pos 0))
		     (while (< pos len)
		       (cond
			((= pos (string-match "\\([^\0]+\\)\0" text pos))
			 (funcall func (match-string 1 text))
			 (setq pos (match-end 0)))
			(t
			 (setq remainder (substring text pos))
			 (setq pos len)))))))
        (proc (make-process :name "ls-files"
			   :buffer nil
			   :coding (or file-name-coding-system
				       default-file-name-coding-system)
			   :command (cl-list* "git" "-C" worktree
					      "--literal-pathspecs" "ls-files"
					      "-z" "--" paths)
			   :connection-type 'pipe
			   :filter filter)))
     (while (or (accept-process-output proc 120)
	       (not (memq (process-status proc) '(exit signal)))))
     (delete-process proc)))

(provide 'git-jump)



