X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH/RFC] gitweb: New improved patchset view
Date: Sun, 29 Oct 2006 11:31:20 -0800 (PST)
Message-ID: <534877.22218.qm@web31805.mail.mud.yahoo.com>
References: <200610291122.30852.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sun, 29 Oct 2006 19:31:46 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=peX1Z52JuUIn/o54sxoUPUy9tS3d9SG64eL+7XZUeVMDSNO+CB/AI251+paPjta+QIiyr4zGu1mBIG+Jd4yWSm6Z/5YIwSQepbRxw/IvOu6QuOkihYkXAlZxTc6RJ7gALjbZY8oSjhWT9YrQmR5XGNQyYyu24/7HpDKOFnyJcU0=  ;
X-YMail-OSG: T8Na7kkVM1lj5YjQZE6O6qJ073xSW7p2pIPI05eqx7Zx2LlM3qvtnBMFxMN4gqam94zkJ8GlUCkv8Bd6vzyMw8bLLFveMbB1Rak_YyrIQ8B.rBj7J_cmMuN87jHpUd1h_sTg9xHCfZg-
In-Reply-To: <200610291122.30852.jnareb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30441>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeGNS-0008T2-8h for gcvg-git@gmane.org; Sun, 29 Oct
 2006 20:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965346AbWJ2TbW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 14:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965328AbWJ2TbW
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 14:31:22 -0500
Received: from web31805.mail.mud.yahoo.com ([68.142.207.68]:37555 "HELO
 web31805.mail.mud.yahoo.com") by vger.kernel.org with SMTP id S965349AbWJ2TbV
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 14:31:21 -0500
Received: (qmail 31924 invoked by uid 60001); 29 Oct 2006 19:31:20 -0000
Received: from [71.80.233.118] by web31805.mail.mud.yahoo.com via HTTP; Sun,
 29 Oct 2006 11:31:20 PST
To: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Sender: git-owner@vger.kernel.org

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Changes:
> * "gitweb diff header" which looked for example like below:
>     file:_<sha1 before>_ -> file:_<sha1 after>_
>   where 'file' is file type and '<sha1>' is full sha1 of blob, is link
>   and uses default link style is changed to
>     diff --git a/<file before> b/<file after>
>   where <file> is hidden link (i.e. underline on hover, only)
>   to appropriate version of file. If file is added, a/<file> is not
>   hyperlinked, if file is deleted, b/<file> is not hyperlinked.

I like it and I like the "hidden" links.

> * there is added "extended diff header", with <path> and <hash>
>   hyperlinked (and <hash> shortened to 7 characters), and <mode>
>   explained: '<mode>' is extnded to '<mode>/<symbolic mode> (<file type>)'.

I like that too, but would leave "100644/-rw-r--r-- (file)" out.

There is a bug in the code: the first index link is the same
as the second, while the first should upload the sha-7 it points to.
For example:
index 743f02b..c821e22
Both point to c821e22.  Please fix that.

> * <file> hyperlinking should work also when <file> is originally
>   quoted. For now we present filename quoted. This needed changes to
>   parse_difftree_raw_line subroutine.

I didn't see where you've quoted file names, but I'm a bit hesitant
to quote anything unnecessarily in the visual output.

> * from-file/to-file two-line header lines have slightly darker color
>   than removed/added lines.

Good.

> * chunk header has now delicate line above for easier finding chunk
>   boundary, and top margin of 1px.

Good.

> Controversial ideas:
> * All links in patch header are hidden

Love those hidden gems.

> * Hashes are shortened to 7 characters

That's ok as long as the output is consisent with real git diff.
That is, a user using git can recognize this commitdiff output and a user
using this gitweb commitdiff output can recognize a git diff output.

> * Filenames are presented quoted

I wouldn't do that.

> * Marking of chunk beginning

I like the fine lines and their color as it is shown in your server.

> * No hyperlink for renamed from/to header (bug)

I'm sure you'll fix that.

Overall I like this patch.  Why?  Because it makes gitweb commitdiff
output as similar as possible to git-diff output. This is always a good
thing, since both beginners and advanced git users can recognize one
or the other depending where they are coming from (gitweb or git).

   Luben


> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
>  gitweb/gitweb.css  |   46 ++++++++++++---
>  gitweb/gitweb.perl |  159 ++++++++++++++++++++++++++++++---------------------
>  2 files changed, 131 insertions(+), 74 deletions(-)
> 
> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index 83d900d..3aeceed 100644
> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
> @@ -303,6 +303,33 @@ td.mode {
>  	font-family: monospace;
>  }
>  
> +
> +div.diff.header,
> +div.diff.extended_header {
> +	white-space: normal;
> +}
> +
> +div.diff.header {
> +	font-weight: bold;
> +
> +	background-color: #edece6;
> +
> +	margin-top: 4px;
> +	padding: 4px 0px 2px 0px;
> +	border: solid #d9d8d1;
> +	border-width: 1px 0px 1px 0px;
> +}
> +
> +div.diff.extended_header,
> +div.diff.extended_header a.list {
> +	color: #777777;
> +}
> +
> +div.diff.extended_header {
> +	background-color: #f6f5ee;
> +	padding: 2px 0px 2px 0px;
> +}
> +
>  div.diff a.list {
>  	text-decoration: none;
>  }
> @@ -312,31 +339,34 @@ div.diff a.list:hover {
>  }
>  
>  div.diff.to_file a.list,
> -div.diff.to_file,
> +div.diff.to_file {
> +	color: #007000;
> +}
> +
>  div.diff.add {
>  	color: #008800;
>  }
>  
>  div.diff.from_file a.list,
> -div.diff.from_file,
> +div.diff.from_file {
> +	color: #aa0000;
> +}
> +
>  div.diff.rem {
>  	color: #cc0000;
>  }
>  
>  div.diff.chunk_header {
>  	color: #990099;
> +	border: dotted #ffbbff;
> +	border-width: 1px 0px 0px 0px;
> +	margin-top: 1px;
>  }
>  
>  div.diff.incomplete {
>  	color: #cccccc;
>  }
>  
> -div.diff_info {
> -	font-family: monospace;
> -	color: #000099;
> -	background-color: #edece6;
> -	font-style: italic;
> -}
>  
>  div.index_include {
>  	border: solid #d9d8d1;
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index cbab3c9..2d971ac 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1255,9 +1255,12 @@ sub parse_difftree_raw_line {
>  		$res{'status'} = $5;
>  		$res{'similarity'} = $6;
>  		if ($res{'status'} eq 'R' || $res{'status'} eq 'C') { # renamed or copied
> -			($res{'from_file'}, $res{'to_file'}) = map { unquote($_) } split("\t", $7);
> +			($res{'from_file_raw'}, $res{'to_file_raw'}) = split("\t", $7);
> +			$res{'from_file'} = unquote($res{'from_file_raw'});
> +			$res{'to_file'}   = unquote($res{'to_file_raw'});
>  		} else {
> -			$res{'file'} = unquote($7);
> +			$res{'file_raw'} = $7;
> +			$res{'file'} = unquote($res{'file_raw'});
>  		}
>  	}
>  	# 'c512b523472485aef4fff9e57b229d9d243c967f'
> @@ -2024,6 +2027,7 @@ sub git_patchset_body {
>  	my $in_header = 0;
>  	my $patch_found = 0;
>  	my $diffinfo;
> +	my (@from_subst, @to_subst);
>  
>  	print "<div class=\"patchset\">\n";
>  
> @@ -2033,6 +2037,7 @@ sub git_patchset_body {
>  
>  		if ($patch_line =~ m/^diff /) { # "git diff" header
>  			# beginning of patch (in patchset)
> +
>  			if ($patch_found) {
>  				# close previous patch
>  				print "</div>\n"; # class="patch"
> @@ -2042,11 +2047,59 @@ sub git_patchset_body {
>  			}
>  			print "<div class=\"patch\" id=\"patch". ($patch_idx+1) ."\">\n";
>  
> +			# read and prepare patch information
>  			if (ref($difftree->[$patch_idx]) eq "HASH") {
> +				# pre-parsed (or generated by hand)
>  				$diffinfo = $difftree->[$patch_idx];
>  			} else {
>  				$diffinfo = parse_difftree_raw_line($difftree->[$patch_idx]);
>  			}
> +			if ($diffinfo->{'status'} ne "A") { # not new (added) file
> +				my $quot = '';
> +				my $from_text;
> +				my $file_raw = $diffinfo->{'from_file_raw'} || $diffinfo->{'file_raw'};
> +				if ($file_raw =~ s/^"(.*)"$/\1/) {
> +					$from_text = qq("a/$file_raw");
> +					$quot = '"';
> +				} else {
> +					$from_text =  qq(a/$file_raw);
> +				}
> +				my $file = $diffinfo->{'from_file'} || $diffinfo->{'file'};
> +				my $from_link =
> +					$cgi->a({-href => href(action=>"blob", hash_base=>$hash_base,
> +					                      hash=>$diffinfo->{'from_id'}, file_name=>$file),
> +					        -class => "list"}, esc_html($file_raw));
> +				my $hash_link =
> +					$cgi->a({-href => href(action=>"blob", hash_base=>$hash_base,
> +					                      hash=>$diffinfo->{'to_id'}, file_name=>$file),
> +					        -class => "list"}, substr($diffinfo->{'from_id'},0,7));
> +				@from_subst = 
> +					($from_text, "${quot}a/$from_link${quot}",
> +					$diffinfo->{'from_id'} . '\.\.', "$hash_link..");
> +			}
> +			if ($diffinfo->{'status'} ne "D") { # not deleted file
> +				my $quot = '';
> +				my $to_text;
> +				my $file_raw = $diffinfo->{'to_file_raw'} || $diffinfo->{'file_raw'};
> +				if ($file_raw =~ s/^"(.*)"$/\1/) {
> +					$to_text = qq("b/$file_raw");
> +					$quot = '"';
> +				} else {
> +					$to_text =  qq(b/$file_raw);
> +				}
> +				my $file = $diffinfo->{'to_file'} || $diffinfo->{'file'};
> +				my $to_link =
> +					$cgi->a({-href => href(action=>"blob", hash_base=>$hash_base,
> +					                      hash=>$diffinfo->{'to_id'}, file_name=>$file),
> +					        -class => "list"}, esc_html($file_raw));
> +				my $hash_link =
> +					$cgi->a({-href => href(action=>"blob", hash_base=>$hash_base,
> +					                      hash=>$diffinfo->{'to_id'}, file_name=>$file),
> +					        -class => "list"}, substr($diffinfo->{'to_id'},0,7));
> +				@to_subst =
> +					($to_text, "${quot}b/$to_link${quot}",
> +					 '\.\.' . $diffinfo->{'to_id'}, "..$hash_link");
> +			}
>  			$patch_idx++;
>  
>  			# for now we skip empty patches
> @@ -2056,82 +2109,56 @@ sub git_patchset_body {
>  				next LINE;
>  			}
>  
> -			if ($diffinfo->{'status'} eq "A") { # added
> -				print "<div class=\"diff_info\">" . file_type($diffinfo->{'to_mode'}) . ":" .
> -				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
> -				                             hash=>$diffinfo->{'to_id'}, file_name=>$diffinfo->{'file'})},
> -				              $diffinfo->{'to_id'}) . " (new)" .
> -				      "</div>\n"; # class="diff_info"
> -
> -			} elsif ($diffinfo->{'status'} eq "D") { # deleted
> -				print "<div class=\"diff_info\">" . file_type($diffinfo->{'from_mode'}) . ":" .
> -				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash_parent,
> -				                             hash=>$diffinfo->{'from_id'},
> file_name=>$diffinfo->{'file'})},
> -				              $diffinfo->{'from_id'}) . " (deleted)" .
> -				      "</div>\n"; # class="diff_info"
> -
> -			} elsif ($diffinfo->{'status'} eq "R" || # renamed
> -			         $diffinfo->{'status'} eq "C" || # copied
> -			         $diffinfo->{'status'} eq "2") { # with two filenames (from git_blobdiff)
> -				print "<div class=\"diff_info\">" .
> -				      file_type($diffinfo->{'from_mode'}) . ":" .
> -				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash_parent,
> -				                             hash=>$diffinfo->{'from_id'},
> file_name=>$diffinfo->{'from_file'})},
> -				              $diffinfo->{'from_id'}) .
> -				      " -> " .
> -				      file_type($diffinfo->{'to_mode'}) . ":" .
> -				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
> -				                             hash=>$diffinfo->{'to_id'},
> file_name=>$diffinfo->{'to_file'})},
> -				              $diffinfo->{'to_id'});
> -				print "</div>\n"; # class="diff_info"
> -
> -			} else { # modified, mode changed, ...
> -				print "<div class=\"diff_info\">" .
> -				      file_type($diffinfo->{'from_mode'}) . ":" .
> -				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash_parent,
> -				                             hash=>$diffinfo->{'from_id'},
> file_name=>$diffinfo->{'file'})},
> -				              $diffinfo->{'from_id'}) .
> -				      " -> " .
> -				      file_type($diffinfo->{'to_mode'}) . ":" .
> -				      $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
> -				                             hash=>$diffinfo->{'to_id'}, file_name=>$diffinfo->{'file'})},
> -				              $diffinfo->{'to_id'});
> -				print "</div>\n"; # class="diff_info"
> -			}
> +			# print "git diff" header
> +			$patch_line =~ s/$from_subst[0]/$from_subst[1]/ if @from_subst;
> +			$patch_line =~ s/$to_subst[0]/$to_subst[1]/ if @to_subst;
> +			print "<div class=\"diff header\">$patch_line</div>\n";
>  
> -			#print "<div class=\"diff extended_header\">\n";
> +			print "<div class=\"diff extended_header\">\n";
>  			$in_header = 1;
>  			next LINE;
>  		} # start of patch in patchset
>  
> +		if ($in_header) {
> +			if ($patch_line !~ m/^---/) {
> +				# match <path>
> +				if ($patch_line =~ m|a/|) {
> +					$patch_line =~ s/$from_subst[0]/$from_subst[1]/ if @from_subst;
> +				}
> +				if ($patch_line =~ m|b/|) {
> +					$patch_line =~ s/$to_subst[0]/$to_subst[1]/ if @to_subst;
> +				}
> +				# match <mode>
> +				if ($patch_line =~ m/\s(\d{6})$/) {
> +					$patch_line .= '/' . mode_str($1) . ' (' . file_type($1) . ')';
> +				}
> +				# match <hash>
> +				if ($patch_line =~ m/^index/) {
> +					$patch_line =~ s/0{40}/'0' x 7/e;
> +					$patch_line =~ s/$from_subst[2]/$from_subst[3]/ if @from_subst;
> +					$patch_line =~ s/$to_subst[2]/$to_subst[3]/ if @to_subst;
> +				}
> +				print $patch_line . "<br/>\n";
>  
> -		if ($in_header && $patch_line =~ m/^---/) {
> -			#print "</div>\n"; # class="diff extended_header"
> -			$in_header = 0;
> +			} else {
> +				#$patch_line =~ m/^---/;
> +				print "</div>\n"; # class="diff extended_header"
> +				$in_header = 0;
> +
> +				$patch_line =~ s/$from_subst[0]/$from_subst[1]/ if @from_subst;
> +				print "<div class=\"diff from_file\">$patch_line</div>\n";
>  
> -			my $file = $diffinfo->{'from_file'};
> -			$file  ||= $diffinfo->{'file'};
> -			$file = $cgi->a({-href => href(action=>"blob", hash_base=>$hash_parent,
> -			                               hash=>$diffinfo->{'from_id'}, file_name=>$file),
> -			                -class => "list"}, esc_html($file));
> -			$patch_line =~ s|a/.*$|a/$file|g;
> -			print "<div class=\"diff from_file\">$patch_line</div>\n";
> +				$patch_line = <$fd>;
> +				chomp $patch_line;
>  
> -			$patch_line = <$fd>;
> -			chomp $patch_line;
> +				#$patch_line =~ m/^+++/;
> +				$patch_line =~ s/$to_subst[0]/$to_subst[1]/ if @to_subst;
> +				print "<div class=\"diff to_file\">$patch_line</div>\n";
>  
> -			#$patch_line =~ m/^+++/;
> -			$file    = $diffinfo->{'to_file'};
> -			$file  ||= $diffinfo->{'file'};
> -			$file = $cgi->a({-href => href(action=>"blob", hash_base=>$hash,
> -			                               hash=>$diffinfo->{'to_id'}, file_name=>$file),
> -			                -class => "list"}, esc_html($file));
> -			$patch_line =~ s|b/.*|b/$file|g;
> -			print "<div class=\"diff to_file\">$patch_line</div>\n";
> +			}
>  
>  			next LINE;
>  		}
> -		next LINE if $in_header;
>  
>  		print format_diff_line($patch_line);
>  	}
> -- 
> 1.4.3.3
> 
> 
> 
> -------------------------------------------------------
> 
> -- 
> Jakub Narebski
> Poland
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
