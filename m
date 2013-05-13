From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 0/4] Coverage support revisited
Date: Mon, 13 May 2013 23:27:24 +0200
Message-ID: <cover.1368479988.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 13 23:27:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uc0Hh-0004uF-0e
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 23:27:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664Ab3EMV1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 17:27:33 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:52715 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751446Ab3EMV1b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 17:27:31 -0400
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 13 May
 2013 23:27:27 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 13 May
 2013 23:27:28 +0200
X-Mailer: git-send-email 1.8.3.rc1.400.g07d6e4a
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224207>

Jens asked me at git-merge if coverage support was still available.
Turns out it is, but there were some weirdnesses.  So this should fix
them.  It is reaaaally slow as you still have to run the tests one by
one; despite claims in the wild that it is multiprocess- safe but
thread-unsafe, I am in fact observing the opposite behavior pretty
clearly.  (As before, it switches to sequential tests automatically,
so you have to edit the Makefile if you want to try with parallel
tests.)

Below is the coverage-untested-functions output; it seems submodule.c
is covered, so there is nothing for Jens to do ;-)


Thomas Rast (4):
  coverage: split build target into compile and test
  coverage: do not delete .gcno files before building
  coverage: set DEFAULT_TEST_TARGET to avoid using prove
  coverage: build coverage-untested-functions by default

 Makefile | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)


--- coverage-untested-functions ---
alloc.c: report
alloc.c: alloc_report
archive-tar.c: write_extended_header
attr.c: git_etc_gitattributes
builtin#add.c: ignore_removal_cb
builtin#apply.c: checkout_target
builtin#apply.c: add_name_limit
builtin#apply.c: option_parse_exclude
builtin#apply.c: option_parse_include
builtin#apply.c: option_parse_z
builtin#blame.c: read_ancestry
builtin#blame.c: sanity_check_refcnt
builtin#blame.c: prepare_initial
builtin#blame.c: blame_move_callback
builtin#branch.c: calc_maxwidth
builtin#checkout-index.c: option_parse_z
builtin#clone.c: remove_junk_on_signal
builtin#commit.c: find_author_by_nickname
builtin#config.c: cmd_repo_config
builtin#fetch.c: unlock_pack_on_signal
builtin#fmt-merge-msg.c: add_branch_desc
builtin#for-each-ref.c: copy_advance
builtin#grep.c: help_callback
builtin#help.c: parse_help_format
builtin#help.c: get_man_viewer_info
builtin#help.c: check_emacsclient_version
builtin#help.c: exec_woman_emacs
builtin#help.c: exec_man_konqueror
builtin#help.c: exec_man_man
builtin#help.c: exec_man_cmd
builtin#help.c: add_man_viewer
builtin#help.c: supported_man_viewer
builtin#help.c: do_add_man_viewer_info
builtin#help.c: add_man_viewer_path
builtin#help.c: add_man_viewer_cmd
builtin#help.c: add_man_viewer_info
builtin#help.c: git_help_config
builtin#help.c: is_git_command
builtin#help.c: prepend
builtin#help.c: cmd_to_page
builtin#help.c: setup_man_path
builtin#help.c: exec_viewer
builtin#help.c: show_man_page
builtin#help.c: show_info_page
builtin#help.c: get_html_page_path
builtin#help.c: open_html
builtin#help.c: show_html_page
builtin#help.c: list_common_guides_help
builtin#help.c: cmd_help
builtin#index-pack.c: delta_pos_compare
builtin#log.c: estimate_commit_count
builtin#log.c: show_early_header
builtin#log.c: log_show_early
builtin#log.c: early_output
builtin#log.c: setup_early_output
builtin#log.c: finish_early_output
builtin#log.c: no_numbered_callback
builtin#log.c: header_callback
builtin#mailsplit.c: populate_maildir_list
builtin#mailsplit.c: maildir_filename_cmp
builtin#mailsplit.c: split_maildir
builtin#merge-base.c: handle_is_ancestor
builtin#merge.c: reset_hard
builtin#merge.c: setup_with_upstream
builtin#pack-objects.c: pbase_tree_cache_ix_incr
builtin#pack-objects.c: try_to_free_from_threads
builtin#pack-objects.c: mark_in_pack_object
builtin#pack-objects.c: ofscmp
builtin#pack-objects.c: add_objects_in_unpacked_packs
builtin#pack-objects.c: option_parse_ulong
builtin#pack-redundant.c: llist_item_put
builtin#pack-redundant.c: llist_item_get
builtin#pack-redundant.c: llist_free
builtin#pack-redundant.c: llist_init
builtin#pack-redundant.c: llist_copy
builtin#pack-redundant.c: llist_insert
builtin#pack-redundant.c: llist_insert_back
builtin#pack-redundant.c: llist_insert_sorted_unique
builtin#pack-redundant.c: llist_sorted_remove
builtin#pack-redundant.c: llist_sorted_difference_inplace
builtin#pack-redundant.c: pack_list_insert
builtin#pack-redundant.c: pack_list_size
builtin#pack-redundant.c: pack_list_difference
builtin#pack-redundant.c: cmp_two_packs
builtin#pack-redundant.c: pll_free
builtin#pack-redundant.c: get_permutations
builtin#pack-redundant.c: is_superset
builtin#pack-redundant.c: sizeof_union
builtin#pack-redundant.c: get_pack_redundancy
builtin#pack-redundant.c: pack_set_bytecount
builtin#pack-redundant.c: minimize
builtin#pack-redundant.c: load_all_objects
builtin#pack-redundant.c: cmp_local_packs
builtin#pack-redundant.c: scan_alt_odb_packs
builtin#pack-redundant.c: add_pack
builtin#pack-redundant.c: add_pack_file
builtin#pack-redundant.c: load_all
builtin#pack-redundant.c: cmd_pack_redundant
builtin#push.c: advise_use_upstream
builtin#push.c: advise_checkout_pull_push
builtin#push.c: advise_ref_needs_force
builtin#read-tree.c: debug_stage
builtin#read-tree.c: debug_merge
builtin#reflog.c: find_cfg_ent
builtin#remote-ext.c: send_git_request
builtin#remote-fd.c: command_loop
builtin#remote-fd.c: cmd_remote_fd
builtin#rev-list.c: show_edge
builtin#rev-list.c: print_var_str
builtin#rev-list.c: print_var_int
builtin#rev-list.c: show_bisect_vars
builtin#rev-parse.c: anti_reference
builtin#rev-parse.c: show_datestring
builtin#send-pack.c: print_helper_status
builtin#shortlog.c: compare_by_number
builtin#shortlog.c: parse_uint
builtin#show-branch.c: append_tag_ref
builtin#show-branch.c: count_slash
builtin#show-branch.c: append_matching_ref
builtin#show-branch.c: parse_reflog_param
builtin#show-ref.c: add_existing
builtin#show-ref.c: exclude_existing
builtin#show-ref.c: exclude_existing_callback
builtin#show-ref.c: help_callback
builtin#unpack-objects.c: add_delta_to_list
combine-diff.c: reuse_combine_diff
compat#terminal.c: restore_term_on_signal
compat#terminal.c: restore_term
compat#terminal.c: disable_echo
compat#terminal.c: git_terminal_prompt
config.c: git_etc_gitconfig
config.c: write_error
connect.c: enable_keepalive
connect.c: ai_name
connect.c: git_tcp_connect_sock
connect.c: git_tcp_connect
connect.c: get_port
credential-cache--daemon.c: cleanup_socket_on_signal
date.c: date_midnight
date.c: date_tea
diff.c: parse_algorithm_value
diff.c: remove_tempfile_on_signal
diffcore-order.c: prepare_order
diffcore-order.c: match_order
diffcore-order.c: compare_pair_order
diffcore-order.c: diffcore_order
dir.c: strcmp_icase
environment.c: have_git_dir
exec_cmd.c: system_path
exec_cmd.c: prepare_git_cmd
exec_cmd.c: execv_git_cmd
exec_cmd.c: execl_git_cmd
fast-import.c: checkpoint_signal
fetch-pack.c: clear_marks
fsck.c: fsck_error_function
graph.c: column_get_color_code
grep.c: compile_pcre_regexp
grep.c: pcrematch
grep.c: free_pcre_regexp
grep.c: indent
grep.c: dump_grep_pat
grep.c: dump_grep_expression_1
grep.c: dump_grep_expression
help.c: clean_cmdnames
help.c: pretty_print_string_list
help.c: list_commands
help.c: git_unknown_cmd_config
help.c: levenshtein_compare
help.c: add_cmd_list
help.c: help_unknown_cmd
http-backend.c: inflate_request
http-backend.c: die_webcgi
http.c: fread_buffer
http.c: ioctl_buffer
http.c: fwrite_buffer
http.c: fwrite_null
http.c: process_curl_messages
http.c: http_options
http.c: init_curl_http_auth
http.c: has_cert_password
http.c: get_curl_handle
http.c: set_from_env
http.c: http_init
http.c: http_cleanup
http.c: get_active_slot
http.c: start_active_slot
http.c: add_fill_function
http.c: fill_active_slots
http.c: step_active_slots
http.c: run_active_slot
http.c: closedown_active_slot
http.c: release_active_slot
http.c: finish_active_slot
http.c: finish_all_active_slots
http.c: needs_quote
http.c: quote_ref_url
http.c: append_remote_object_url
http.c: get_remote_object_url
http.c: handle_curl_result
http.c: http_request
http.c: http_request_reauth
http.c: http_get_strbuf
http.c: http_get_file
http.c: http_fetch_ref
http.c: fetch_pack_index
http.c: fetch_and_setup_pack_index
http.c: http_get_info_packs
http.c: release_http_pack_request
http.c: finish_http_pack_request
http.c: new_http_pack_request
http.c: fwrite_sha1_file
http.c: new_http_object_request
http.c: process_http_object_request
http.c: finish_http_object_request
http.c: abort_http_object_request
http.c: release_http_object_request
http-push.c: xml_entities
http-push.c: curl_setup_http_get
http-push.c: curl_setup_http
http-push.c: get_dav_token_headers
http-push.c: process_response
http-push.c: start_fetch_loose
http-push.c: start_mkcol
http-push.c: start_fetch_packed
http-push.c: start_put
http-push.c: start_move
http-push.c: refresh_lock
http-push.c: check_locks
http-push.c: release_request
http-push.c: finish_request
http-push.c: fill_active_slot
http-push.c: add_fetch_request
http-push.c: add_send_request
http-push.c: fetch_indices
http-push.c: one_remote_object
http-push.c: handle_lockprop_ctx
http-push.c: handle_new_lock_ctx
http-push.c: xml_start_tag
http-push.c: xml_end_tag
http-push.c: xml_cdata
http-push.c: lock_remote
http-push.c: unlock_remote
http-push.c: remove_locks
http-push.c: remove_locks_on_signal
http-push.c: process_ls_object
http-push.c: process_ls_ref
http-push.c: handle_remote_ls_ctx
http-push.c: remote_ls
http-push.c: get_remote_object_list
http-push.c: locking_available
http-push.c: add_one_object
http-push.c: process_blob
http-push.c: process_tree
http-push.c: get_delta
http-push.c: update_remote
http-push.c: one_remote_ref
http-push.c: get_dav_remote_heads
http-push.c: add_remote_info_ref
http-push.c: update_remote_info_refs
http-push.c: remote_exists
http-push.c: fetch_symref
http-push.c: verify_merge_base
http-push.c: delete_remote_branch
http-push.c: run_request_queue
ident.c: author_ident_sufficiently_given
levenshtein.c: levenshtein
lockfile.c: remove_lock_file_on_signal
lockfile.c: unable_to_lock_message
lockfile.c: unable_to_lock_error
lockfile.c: unable_to_lock_index_die
log-tree.c: add_graft_decoration
log-tree.c: show_parents
log-tree.c: show_children
log-tree.c: which_parent
log-tree.c: is_common_merge
log-tree.c: show_one_mergetag
merge-blobs.c: common_outf
name-hash.c: remove_dir_entry
name-hash.c: slow_same_name
name-hash.c: free_dir_entry
notes.c: combine_notes_ignore
object.c: object_list_insert
object.c: object_list_contains
pager.c: wait_for_pager
pager.c: wait_for_pager_signal
parse-options.c: optbug
path.c: getpw_str
path.c: daemon_avoid_alias
pkt-line.c: packet_read_line_buf
preload-index.c: preload_thread
progress.c: progress_interval
prompt.c: git_getpass
quote.c: sq_dequote
read-cache.c: different_name
read-cache.c: create_alias_ce
read-cache.c: expand_name_field
refs.c: for_each_branch_ref
refs.c: for_each_remote_ref
refs.c: ref_msg
remote.c: remote_has_url
revision.c: prepare_show_merge
run-command.c: cleanup_children_on_signal
run-command.c: dup_devnull
run-command.c: run_command_v_opt_cd_env
sha1_file.c: sha1_get_pack_name
sha1_file.c: sha1_pack_name
sha1_file.c: sha1_pack_index_name
sha1_file.c: release_pack_memory
sha1_file.c: try_to_free_pack_memory
sha1_file.c: parse_pack_index
sha1_file.c: write_pack_access_log
sha1_file.c: has_pack_index
sha1-lookup.c: sha1_entry_pos
sh-i18n--envsubst.c: cmp_string
strbuf.c: strbuf_addstr_xml_quoted
strbuf.c: is_rfc3986_reserved
string-list.c: print_string_list
test-ctype.c: report_error
test-wildmatch.c: perf
transport.c: external_specification_len
transport-helper.c: xchgline
transport-helper.c: standard_options
transport-helper.c: fetch_with_fetch
transport-helper.c: connect_helper
transport-helper.c: push_refs_with_push
transport-helper.c: has_attribute
tree.c: read_one_entry
tree-walk.c: match_wildcard_base
unix-socket.c: chdir_len
unpack-trees.c: debug_path
unpack-trees.c: debug_name_entry
unpack-trees.c: debug_unpack_callback
unpack-trees.c: verify_clean_submodule
unpack-trees.c: icase_exists
upload-pack.c: check_non_tip
url.c: str_end_url_with_slash
utf8.c: is_utf8
varint.c: decode_varint
varint.c: encode_varint
vcs-svn#fast_export.c: fast_export_truncate
vcs-svn#fast_export.c: die_short_read
vcs-svn#svndump.c: die_short_read
wrapper.c: do_nothing
wrapper.c: warn_on_inaccessible
write_or_die.c: check_pipe
xdiff#xhistogram.c: fall_back_to_classic_diff
xdiff#xpatience.c: fall_back_to_classic_diff
xdiff#xutils.c: xdl_fall_back_diff
zlib.c: git_inflate_init_gzip_only
zlib.c: git_deflate_init_gzip


-- 
1.8.3.rc1.400.g07d6e4a
